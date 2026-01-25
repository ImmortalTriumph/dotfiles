#!/usr/bin/env python3
"""
Cava visualizer - converts raw cava output to ASCII art for eww dashboard.
Reads from /tmp/cava.raw (FIFO with semicolon-separated ASCII values)
Writes to /tmp/visualizer.txt (Pango markup visualization with gruvbox colors)
"""

import signal
import sys
import os

# Configuration
RAW_INPUT = "/tmp/cava.raw"
OUTPUT_FILE = "/tmp/visualizer.txt"
NUM_BARS = 180
HEIGHT = 14

# ASCII characters for bar heights (index 0 = empty, higher = more filled)
# Vertical block gradient for height display
BAR_CHARS = [" ", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]

# Gruvbox color gradient (bottom to top) - bright yellow to red fading
GRUVBOX_COLORS = [
    "#fabd2f",  # bright yellow (bottom/low)
    "#f9a825",  # yellow-orange
    "#fe8019",  # bright orange
    "#f4511e",  # orange-red
    "#fb4934",  # bright red (top/high)
]

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


def get_color_for_row(row):
    """Get gruvbox color based on row height (0 = bottom, HEIGHT-1 = top)."""
    if HEIGHT <= 1:
        return GRUVBOX_COLORS[0]
    # Map row to color index
    color_idx = int((row / (HEIGHT - 1)) * (len(GRUVBOX_COLORS) - 1))
    return GRUVBOX_COLORS[min(color_idx, len(GRUVBOX_COLORS) - 1)]


def escape_pango(text):
    """Escape special characters for Pango markup."""
    return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


def values_to_ascii(values):
    """Convert normalized values to Pango markup with gruvbox gradient colors."""
    lines = []

    for row in range(HEIGHT - 1, -1, -1):
        line = ""
        threshold = row / HEIGHT
        color = get_color_for_row(row)

        for val in values:
            if val <= threshold:
                # Below threshold - empty space
                line += " "
            elif val >= (row + 1) / HEIGHT:
                # Fully above this row - full block
                line += BAR_CHARS[-1]
            else:
                # Partially filled - calculate which character
                cell_fill = (val - threshold) * HEIGHT
                char_idx = min(len(BAR_CHARS) - 1, max(1, int(cell_fill * (len(BAR_CHARS) - 1))))
                line += BAR_CHARS[char_idx]

        # Escape and wrap line with Pango color span
        escaped_line = escape_pango(line)
        lines.append(f'<span foreground="{color}">{escaped_line}</span>')

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
