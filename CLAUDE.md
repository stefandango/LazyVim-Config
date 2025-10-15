# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration with custom plugins and configurations primarily focused on development with Go, C#/.NET, and general programming tasks. The configuration follows LazyVim's modular plugin architecture with custom keymaps and options.

## Code Formatting & Linting

- **Lua formatting**: Use `stylua` for Lua code formatting
  - Configuration: `stylua.toml` (2 spaces, 120 column width)
  - Command: `stylua .` to format all Lua files

## Key Architecture & Patterns

### Plugin Management
- Uses **Lazy.nvim** as the plugin manager
- Configuration follows LazyVim's structure:
  - `lua/config/` - Core configuration files (keymaps, options, lazy setup)
  - `lua/plugins/` - Individual plugin configurations
- Plugin configurations return tables with plugin specs
- Lazy loading is generally disabled (`lazy = false`) for custom plugins

### Configuration Structure
- `init.lua` - Entry point that bootstraps lazy.nvim and loads config
- `lazyvim.json` - LazyVim extras configuration (language support, features)
- `lazy-lock.json` - Plugin version lockfile (auto-generated)

### LazyVim Extras Enabled
- `lazyvim.plugins.extras.coding.yanky` - Enhanced yank/paste functionality
- `lazyvim.plugins.extras.lang.go` - Go language support
- `lazyvim.plugins.extras.lang.json` - JSON language support
- `lazyvim.plugins.extras.lang.markdown` - Markdown support
- `lazyvim.plugins.extras.lang.omnisharp` - C# language support
- `lazyvim.plugins.extras.test.core` - Testing framework support
- `lazyvim.plugins.extras.util.dot` - Dotfile utilities

### Custom Options (`lua/config/options.lua`)
- Tab width: 4 spaces (overrides LazyVim's default of 2)
- No line wrapping
- Search highlighting disabled (`hlsearch = false`)
- Color column at 120 characters
- Command height set to 0 (`cmdheight = 0`)
- Scroll offset of 8 lines

### Custom Keymaps (`lua/config/keymaps.lua`)
Key custom mappings include:
- `+`/`-` for increment/decrement (instead of Ctrl+a/Ctrl+x)
- `<A-a>` for select all
- `J`/`K` in visual mode to move selected lines
- Enhanced cursor positioning for navigation commands
- `<leader>x` to make current file executable
- `<leader>p` in visual mode for better paste behavior

### Development-Specific Plugins

#### C#/.NET Development
- **easy-dotnet.nvim**: Local plugin for .NET project management
  - Located at `~/Dev/nvimplugins/easy-dotnet.nvim`
  - Provides commands for build, test, run, restore, watch
  - Custom terminal integration for dotnet commands
  - Keybinding: `<C-p>` to run projects
  - Auto-detects outdated packages on `.csproj` changes

- **roslyn.nvim**: Advanced C# language server
  - Configured with detailed inlay hints
  - Razor/Blazor file type support
  - Integration with rzls.nvim for enhanced features
  - Enhanced keymaps: `<leader>cr` (rename), `<leader>ca` (code actions), `<leader>cf` (format)

- **Enhanced Debugging**: Full DAP setup with netcoredbg
  - Debug keymaps: `<leader>db` (breakpoint), `<leader>dc` (continue), `<leader>ds` (step over)
  - Auto-opening debug UI with scopes, breakpoints, and console
  - Support for both launch and attach debugging

- **Testing Integration**: Advanced neotest configuration
  - Test keymaps: `<leader>tt` (run test), `<leader>tf` (run file), `<leader>td` (debug test)
  - Test discovery based on project naming conventions
  - Watch mode and output panel support

- **Solution Explorer**: Enhanced neo-tree for C# projects
  - Filters out bin/, obj/, .vs/ directories automatically
  - Keymaps: `<leader>se` (open), `<leader>st` (toggle), `<leader>sf` (focus)

- **Custom C# Snippets**: LuaSnip integration with C# templates
  - class, interface, method, property, constructor snippets
  - Test method templates with Arrange/Act/Assert structure
  - API controller templates

- **Project Management Keymaps**:
  - `<leader>ds` - Add project to solution
  - `<leader>dp` - Create new dotnet project
  - `<leader>dr` - Dotnet restore
  - `<leader>db` - Dotnet build
  - `<leader>dt` - Dotnet test

#### Go Development
- Enabled via LazyVim extras (`lazyvim.plugins.extras.lang.go`)
- Includes neotest-golang for testing integration
- DAP (Debug Adapter Protocol) support with nvim-dap-go

#### Quality of Life
- **hardtime.nvim**: Helps break bad Vim habits by discouraging repetitive key usage
- **rose-pine**: Color scheme configuration
- Custom lualine configuration for status line

### Plugin Development Patterns
When adding new plugins:
1. Create new `.lua` file in `lua/plugins/`
2. Return a table with plugin specs
3. Use `dir` parameter for local plugin development
4. Configure using `opts` table or `config` function
5. Add appropriate `ft` (filetype) restrictions for language-specific plugins

### Local Plugin Development
- Custom plugins are stored in `~/Dev/nvimplugins/`
- Use `dir` parameter in plugin spec to reference local paths
- Example pattern shown in `stefandangoPlugin.lua` (currently disabled)

## File Structure Notes
- `example.lua` contains comprehensive examples of plugin configuration patterns but is disabled
- Most plugin files follow a simple return table structure
- Configuration files use clear separation between LazyVim defaults and custom overrides