#!/usr/bin/env python3
"""
Cava visualizer - converts raw cava output to ASCII art for eww dashboard.
Reads from /tmp/cava.raw (FIFO with semicolon-separated ASCII values)
Writes to /tmp/visualizer.txt (ASCII art visualization)
"""

import signal
import sys
import os

# Configuration
RAW_INPUT = "/tmp/cava.raw"
OUTPUT_FILE = "/tmp/visualizer.txt"
NUM_BARS = 50
HEIGHT = 8

# ASCII characters for bar heights (from empty to full)
BAR_CHARS = [" ", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]

# Decay factor for smooth animation (0-1, higher = slower decay)
DECAY = 0.7

# Track previous values for decay effect
prev_values = [0.0] * NUM_BARS

running = True


def signal_handler(sig, frame):
    """Handle shutdown signals gracefully."""
    global running
    running = False


def parse_line(line):
    """Parse a single line of cava output (semicolon-separated values)."""
    values = []
    for v in line.strip().split(";"):
        v = v.strip()
        if v:
            try:
                values.append(int(v))
            except ValueError:
                continue
    return values if values else None


def normalize_values(values):
    """Normalize values to 0-1 range using dynamic scaling."""
    if not values:
        return [0.0] * NUM_BARS

    # Pad or truncate to NUM_BARS
    if len(values) < NUM_BARS:
        values = values + [0] * (NUM_BARS - len(values))
    elif len(values) > NUM_BARS:
        values = values[:NUM_BARS]

    # Dynamic normalization based on current frame's max value
    max_val = max(values) if values else 1
    if max_val == 0:
        return [0.0] * NUM_BARS

    return [v / max_val for v in values]


def apply_decay(current, previous):
    """Apply decay effect for smoother animation."""
    result = []
    for i, (curr, prev) in enumerate(zip(current, previous)):
        # Value rises instantly but falls with decay
        if curr >= prev:
            result.append(curr)
        else:
            result.append(max(curr, prev * DECAY))
    return result


def values_to_ascii(values):
    """Convert normalized values to ASCII art."""
    lines = []

    for row in range(HEIGHT - 1, -1, -1):
        line = ""
        threshold = row / HEIGHT

        for val in values:
            if val <= threshold:
                line += " "
            else:
                # Calculate which character to use based on position within cell
                cell_fill = (val - threshold) * HEIGHT
                char_idx = min(len(BAR_CHARS) - 1, int(cell_fill * len(BAR_CHARS)))
                line += BAR_CHARS[char_idx]

        lines.append(line)

    return "\n".join(lines)


def write_output(ascii_art):
    """Write ASCII art to output file atomically."""
    tmp_file = OUTPUT_FILE + ".tmp"
    try:
        with open(tmp_file, "w") as f:
            f.write(ascii_art)
        os.rename(tmp_file, OUTPUT_FILE)
    except IOError as e:
        print(f"Error writing output: {e}", file=sys.stderr)


def main():
    global prev_values, running

    # Set up signal handlers
    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    # Wait for FIFO to exist
    while running and not os.path.exists(RAW_INPUT):
        import time
        time.sleep(0.1)

    if not running:
        return

    print(f"cava-viz started, reading from {RAW_INPUT}", file=sys.stderr)

    # Open FIFO and read line by line (streaming)
    # Each line from cava is a complete frame (semicolon-separated values)
    try:
        with open(RAW_INPUT, "r") as fifo:
            for line in fifo:
                if not running:
                    break

                # Parse the line
                raw_values = parse_line(line)
                if raw_values is None:
                    continue

                # Normalize values
                normalized = normalize_values(raw_values)

                # Apply decay for smooth animation
                smoothed = apply_decay(normalized, prev_values)
                prev_values = smoothed

                # Convert to ASCII and write
                ascii_art = values_to_ascii(smoothed)
                write_output(ascii_art)

    except (FileNotFoundError, IOError) as e:
        print(f"Error reading FIFO: {e}", file=sys.stderr)
        sys.exit(1)

    print("cava-viz shutting down", file=sys.stderr)


if __name__ == "__main__":
    main()
