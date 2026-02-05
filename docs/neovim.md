# Neovim Configuration Guide

Complete reference for the Neovim 0.11+ configuration with Gruvbox dark theme.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Core Options](#core-options)
3. [Keybindings](#keybindings)
4. [LSP & Completion](#lsp--completion)
5. [Debugging (DAP)](#debugging-dap)
6. [Testing (Neotest)](#testing-neotest)
7. [Java Development](#java-development)
8. [Plugins Reference](#plugins-reference)
9. [Commands](#commands)
10. [File Structure](#file-structure)

---

## Quick Start

```bash
# First launch - install plugins
nvim
:Lazy sync

# Install debug adapters
:MasonInstall codelldb java-debug-adapter java-test

# Check health
:checkhealth
```

---

## Key Notation

| Notation | Key | Description |
|----------|-----|-------------|
| `<leader>` | `Space` | Primary modifier for custom commands. Press Space then the next key(s). |
| `<C-x>` | `Ctrl + x` | Hold Control and press x |
| `<A-x>` | `Alt + x` | Hold Alt and press x |
| `<S-x>` | `Shift + x` | Hold Shift and press x |
| `<CR>` | `Enter` | Enter/Return key |
| `<Esc>` | `Escape` | Escape key |
| `<BS>` | `Backspace` | Backspace key |
| `<Tab>` | `Tab` | Tab key |

**Example:** `<leader>ff` means press `Space`, then `f`, then `f`

---

## Core Options

| Setting | Value | Description |
|---------|-------|-------------|
| Line numbers | Relative | Shows relative line numbers |
| Tab width | 4 spaces | Expandtab enabled |
| Search | Smart case | Case-insensitive unless uppercase used |
| Clipboard | System | Uses `unnamedplus` |
| Mouse | Enabled | Full mouse support |
| Undo | Persistent | Stored in `~/.local/share/nvim/undo` |

---

## Keybindings

### General

| Key | Mode | Action |
|-----|------|--------|
| `<Space>` | n | Leader key |
| `<Esc>` | n | Clear search highlight |
| `jk` | i | Exit insert mode (better-escape) |
| `Y` | n | Yank to end of line |

### File Operations

| Key | Mode | Action |
|-----|------|--------|
| `<leader>w` | n | Save file |
| `<leader>q` | n | Quit |
| `<leader>x` | n | Save and quit |
| `<leader>e` | n | Toggle file explorer (NvimTree) |

### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<C-h/j/k/l>` | n | Navigate between splits |
| `<C-d>` | n | Half page down (centered) |
| `<C-u>` | n | Half page up (centered) |
| `n` / `N` | n | Next/prev search result (centered) |
| `<S-h>` | n | Previous buffer |
| `<S-l>` | n | Next buffer |
| `<leader>bd` | n | Delete buffer |

### Window Management

| Key | Mode | Action |
|-----|------|--------|
| `<C-Up>` | n | Increase height |
| `<C-Down>` | n | Decrease height |
| `<C-Left>` | n | Decrease width |
| `<C-Right>` | n | Increase width |

### Line Movement

| Key | Mode | Action |
|-----|------|--------|
| `<A-j>` | n/v | Move line(s) down |
| `<A-k>` | n/v | Move line(s) up |

### Indentation

| Key | Mode | Action |
|-----|------|--------|
| `<` | v | Dedent (stays in visual) |
| `>` | v | Indent (stays in visual) |

### Telescope (Fuzzy Finder)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep (search text) |
| `<leader>fb` | n | List buffers |
| `<leader>fh` | n | Help tags |
| `<leader>fr` | n | Recent files |

**Inside Telescope:**

| Key | Action |
|-----|--------|
| `<C-j>` | Move selection down |
| `<C-k>` | Move selection up |
| `<C-q>` | Send to quickfix list |
| `<Esc>` | Close |

### Terminal

| Key | Mode | Action |
|-----|------|--------|
| `<leader>tt` | n | Toggle terminal |
| `<leader>tf` | n | Float terminal |
| `<leader>th` | n | Horizontal terminal |
| `<leader>tv` | n | Vertical terminal |
| `<Esc>` | t | Exit terminal mode |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gg` | n | Open LazyGit |
| `<leader>gd` | n | Git diff this file |
| `<leader>gb` | n | Git blame line |

### Session

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ss` | n | Restore session for cwd |
| `<leader>sl` | n | Restore last session |

### Treesitter Selection

| Key | Mode | Action |
|-----|------|--------|
| `<C-Space>` | n | Init selection |
| `<C-Space>` | v | Expand selection |
| `<BS>` | v | Shrink selection |

---

## LSP & Completion

### LSP Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gr` | n | Find references |
| `gi` | n | Go to implementation |
| `K` | n | Hover documentation |
| `<leader>la` | n | Code action |
| `<leader>lr` | n | Rename symbol |
| `<leader>lf` | n | Format buffer |
| `<leader>ls` | n | Signature help |
| `<leader>ld` | n | Line diagnostics |
| `<leader>ll` | n | Trigger linting |
| `[d` | n | Previous diagnostic |
| `]d` | n | Next diagnostic |

### Completion (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<Tab>` | i | Next completion / expand snippet |
| `<S-Tab>` | i | Previous completion |
| `<CR>` | i | Confirm selection |
| `<C-Space>` | i | Trigger completion |
| `<C-e>` | i | Abort completion |
| `<C-b>` | i | Scroll docs up |
| `<C-f>` | i | Scroll docs down |

### Installed LSP Servers

| Server | Languages |
|--------|-----------|
| `lua_ls` | Lua |
| `rust_analyzer` | Rust |
| `pyright` | Python |
| `clangd` | C/C++ |
| `ts_ls` | TypeScript/JavaScript |
| `jdtls` | Java |
| `bashls` | Bash |
| `jsonls` | JSON |
| `yamlls` | YAML |
| `cssls` | CSS |
| `html` | HTML |
| `emmet_ls` | HTML/CSS/JSX |

### Formatters (conform.nvim)

| Language | Formatter |
|----------|-----------|
| JavaScript/TypeScript | prettierd, prettier |
| HTML/CSS/JSON/YAML | prettierd, prettier |
| C/C++ | clang-format |
| Java | google-java-format |
| Python | ruff_format, black |
| Rust | rustfmt |
| Lua | stylua |
| Shell | shfmt |

### Linters (nvim-lint)

| Language | Linter |
|----------|--------|
| JavaScript/TypeScript | eslint_d |
| Python | ruff, mypy |
| C/C++ | cpplint |

---

## Debugging (DAP)

### Core Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Conditional breakpoint |
| `<leader>dl` | n | Log point |
| `<leader>dc` | n | Continue / Start debug |
| `<leader>di` | n | Step into |
| `<leader>do` | n | Step over |
| `<leader>dO` | n | Step out |
| `<leader>dr` | n | Toggle REPL |
| `<leader>dR` | n | Run last config |
| `<leader>dt` | n | Terminate session |
| `<leader>du` | n | Toggle DAP UI |
| `<leader>de` | n/v | Evaluate expression |
| `<leader>dh` | n | Hover variable |
| `<leader>dp` | n | Preview |

### DAP UI Panels

**Right panel:** Scopes, Breakpoints, Stacks, Watches
**Bottom panel:** REPL, Console

### DAP UI Mappings (inside panels)

| Key | Action |
|-----|--------|
| `<CR>` | Expand |
| `o` | Open |
| `d` | Remove |
| `e` | Edit |
| `r` | Open REPL |
| `t` | Toggle |

### Supported Debug Adapters

| Language | Adapter |
|----------|---------|
| C/C++ | codelldb |
| Rust | codelldb |
| Java | java-debug-adapter |

### Debug Workflow

```
1. Compile with debug symbols: g++ -g main.cpp -o main
2. Set breakpoints: <leader>db
3. Start debugging: <leader>dc
4. Step through: <leader>di (into) / <leader>do (over)
5. Inspect: <leader>dh (hover) / <leader>du (UI)
6. Continue/Stop: <leader>dc / <leader>dt
```

---

## Testing (Neotest)

### Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `<leader>Tn` | n | Run nearest test |
| `<leader>Tf` | n | Run all tests in file |
| `<leader>Td` | n | Debug nearest test |
| `<leader>Ts` | n | Stop running test |
| `<leader>Ta` | n | Attach to running test |
| `<leader>To` | n | Open test output |
| `<leader>TO` | n | Toggle output panel |
| `<leader>Tp` | n | Toggle summary panel |
| `[t` | n | Previous failed test |
| `]t` | n | Next failed test |

### Summary Panel Mappings

| Key | Action |
|-----|--------|
| `r` | Run test |
| `d` | Debug test |
| `o` | Show output |
| `e` | Expand all |
| `a` | Attach |
| `m` | Mark |
| `R` | Run marked |
| `D` | Debug marked |
| `u` | Stop |

### Supported Test Frameworks

- **Java:** JUnit (via neotest-java)
- **C++:** Google Test (via neotest-gtest)

---

## Java Development

Java files automatically use nvim-jdtls with enhanced features.

### Java-Specific Keybindings

| Key | Mode | Action |
|-----|------|--------|
| `<leader>jo` | n | Organize imports |
| `<leader>jv` | n/v | Extract variable |
| `<leader>jc` | n/v | Extract constant |
| `<leader>jm` | v | Extract method |
| `<leader>jtc` | n | Test current class |
| `<leader>jtn` | n | Test nearest method |
| `<leader>jd` | n | Setup Java debug |

### Features

- Code completion with LSP
- Inlay hints for parameter names
- Code lens for implementations/references
- Auto-import organization
- Maven/Gradle support
- JUnit test integration
- Debug support with hot code replace

### Project Detection

Detected by: `.git`, `pom.xml`, `build.gradle`, `gradlew`, `mvnw`, `.project`

---

## Plugins Reference

### UI

| Plugin | Purpose |
|--------|---------|
| gruvbox-material.nvim | Colorscheme |
| nvim-tree.lua | File explorer |
| lualine.nvim | Status line |
| bufferline.nvim | Buffer tabs |
| indent-blankline.nvim | Indent guides |
| which-key.nvim | Key hints |
| alpha-nvim | Dashboard |
| noice.nvim | UI improvements |
| nvim-notify | Notifications |
| gitsigns.nvim | Git signs |

### Editing

| Plugin | Purpose |
|--------|---------|
| nvim-autopairs | Auto close brackets |
| nvim-surround | Surround text objects |
| Comment.nvim | Comment toggle |
| better-escape.nvim | `jk` to escape |
| nvim-colorizer.lua | Color preview |
| todo-comments.nvim | Highlight TODOs |

### LSP & Completion

| Plugin | Purpose |
|--------|---------|
| mason.nvim | LSP/DAP installer |
| nvim-lspconfig | LSP configuration |
| nvim-cmp | Completion engine |
| LuaSnip | Snippet engine |
| conform.nvim | Formatting |
| nvim-lint | Linting |
| fidget.nvim | LSP progress |

### Debugging & Testing

| Plugin | Purpose |
|--------|---------|
| nvim-dap | Debug adapter protocol |
| nvim-dap-ui | Debug UI |
| nvim-dap-virtual-text | Inline variable display |
| nvim-jdtls | Java LSP + debug |
| neotest | Test runner |

### Utilities

| Plugin | Purpose |
|--------|---------|
| telescope.nvim | Fuzzy finder |
| nvim-treesitter | Syntax highlighting |
| toggleterm.nvim | Terminal |
| persistence.nvim | Session management |

---

## Commands

### User Commands

| Command | Description |
|---------|-------------|
| `:LazyGit` | Open LazyGit |
| `:FormatDisable` | Disable format-on-save (global) |
| `:FormatDisable!` | Disable format-on-save (buffer) |
| `:FormatEnable` | Enable format-on-save |
| `:ConformInfo` | Show formatter info |

### Plugin Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open plugin manager |
| `:Mason` | Open LSP/DAP installer |
| `:Telescope <picker>` | Open Telescope picker |
| `:NvimTreeToggle` | Toggle file explorer |
| `:TSInstall <lang>` | Install treesitter parser |

---

## File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── ftplugin/
│   └── java.lua               # Java-specific config
└── lua/
    ├── config/
    │   ├── options.lua        # Core vim options
    │   ├── keymaps.lua        # Global keybindings
    │   └── filetype.lua       # Filetype detection
    └── plugins/
        ├── colorscheme.lua    # Gruvbox theme
        ├── lsp.lua            # LSP + Mason
        ├── completion.lua     # nvim-cmp
        ├── telescope.lua      # Fuzzy finder
        ├── treesitter.lua     # Syntax highlighting
        ├── ui.lua             # UI plugins
        ├── utils.lua          # Utility plugins
        ├── formatting.lua     # Formatters + linters
        ├── dap.lua            # Debugging
        └── test.lua           # Testing
```

---

## Surround Plugin

| Action | Keys | Example |
|--------|------|---------|
| Add surround | `ys<motion><char>` | `ysiw"` surrounds word with `"` |
| Add surround (line) | `yss<char>` | `yss)` surrounds line with `()` |
| Change surround | `cs<old><new>` | `cs"'` changes `"` to `'` |
| Delete surround | `ds<char>` | `ds"` deletes surrounding `"` |

---

## Comment Plugin

| Action | Keys |
|--------|------|
| Toggle line comment | `gcc` |
| Toggle block comment | `gbc` |
| Comment motion | `gc<motion>` |

---

## Color Scheme

**Theme:** Gruvbox Material (Hard Contrast)

| Element | Color |
|---------|-------|
| Background | `#1a1a1a` |
| Foreground | `#d9d9d9` |
| Selection | `#252525` |
| Border | `#4d4d4d` |
| Error | `#fb4934` |
| Warning | `#fabd2f` |
| Info | `#83a598` |
| Hint | `#8ec07c` |
| Git Add | `#b8bb26` |
| Git Change | `#83a598` |
| Git Delete | `#fb4934` |
