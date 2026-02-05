# Neovim Debug & Test Guide

Enhanced debugging and testing support for Java and C/C++ development.

---

## Installation

After pulling the dotfiles, open Neovim and run:

```vim
:Lazy sync
:MasonInstall codelldb jdtls java-debug-adapter java-test
```

---

## Debug Adapter Protocol (DAP)

### Keybindings

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Set conditional breakpoint |
| `<leader>dl` | Set log point |
| `<leader>dc` | Continue execution |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dr` | Toggle REPL |
| `<leader>dR` | Run last debug config |
| `<leader>dt` | Terminate debug session |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` | Evaluate expression (visual mode supported) |
| `<leader>dh` | Hover variable info |
| `<leader>dp` | Preview |

### C/C++ Debugging

1. Compile with debug symbols: `g++ -g main.cpp -o main`
2. Set breakpoints with `<leader>db`
3. Start debugging with `<leader>dc`
4. Select "Launch file" and provide the executable path

### Rust Debugging

Same as C++ but executables are typically in `target/debug/`

---

## Java Development

### Overview

Java support uses nvim-jdtls which provides:
- Full LSP support (completion, diagnostics, go-to-definition)
- Code refactoring (extract method/variable/constant)
- Code generation (getters, setters, toString, hashCode, equals)
- JUnit test integration
- Debug support via Java Debug Adapter

### Java-Specific Keybindings

| Key | Action |
|-----|--------|
| `<leader>jo` | Organize imports |
| `<leader>jv` | Extract variable |
| `<leader>jc` | Extract constant |
| `<leader>jm` | Extract method (visual mode) |
| `<leader>jtc` | Test current class |
| `<leader>jtn` | Test nearest method |
| `<leader>jd` | Setup Java debug |

### Java Project Setup

1. Open a Java project (with pom.xml, build.gradle, or .project)
2. Wait for jdtls to initialize (shown in fidget notification)
3. Use standard LSP keymaps for navigation

### Debugging Java

1. Run `<leader>jd` to setup debug configurations
2. Set breakpoints with `<leader>db`
3. Run `<leader>dc` and select a main class

---

## Neotest (Test Runner)

### Keybindings

| Key | Action |
|-----|--------|
| `<leader>Tn` | Run nearest test |
| `<leader>Tf` | Run all tests in file |
| `<leader>Td` | Debug nearest test |
| `<leader>Ts` | Stop running test |
| `<leader>Ta` | Attach to running test |
| `<leader>To` | Open test output |
| `<leader>TO` | Toggle output panel |
| `<leader>Tp` | Toggle summary panel |
| `[t` | Jump to previous failed test |
| `]t` | Jump to next failed test |

### Summary Panel

In the summary panel:
- `r` - Run test
- `d` - Debug test
- `o` - Show output
- `e` - Expand all
- `a` - Attach

---

## DAP UI Layout

When debugging, the UI opens automatically with:

**Right Panel:**
- Scopes (variables in current scope)
- Breakpoints (all breakpoints)
- Stacks (call stack)
- Watches (custom watch expressions)

**Bottom Panel:**
- REPL (debug console)
- Console (program output)

### Virtual Text

During debugging, variable values are shown inline at the end of lines.

---

## Troubleshooting

### C++ debugger not working

```bash
# Verify codelldb is installed
ls ~/.local/share/nvim/mason/packages/codelldb/

# Check if executable has debug symbols
file ./your_program  # Should show "with debug_info"
```

### Java LSP not starting

```bash
# Check jdtls installation
ls ~/.local/share/nvim/mason/packages/jdtls/

# Verify JAVA_HOME
echo $JAVA_HOME

# Check workspace directory
ls ~/.local/share/nvim/jdtls-workspace/
```

### Tests not discovered

- Ensure test files follow naming conventions:
  - Java: `*Test.java` or `Test*.java`
  - C++/GTest: Files containing `TEST()` or `TEST_F()` macros

---

## Quick Reference

```
Debugging workflow:
1. Set breakpoints: <leader>db
2. Start debug: <leader>dc
3. Step through: <leader>di (into) / <leader>do (over)
4. Inspect: <leader>dh (hover) / <leader>du (UI)
5. Continue/Stop: <leader>dc / <leader>dt

Testing workflow:
1. Navigate to test file
2. Run test: <leader>Tn (nearest) / <leader>Tf (file)
3. View results: <leader>To (output) / <leader>Tp (summary)
4. Debug failing: <leader>Td
```
