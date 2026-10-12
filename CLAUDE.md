# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A LazyVim-based Neovim configuration (Neovim 0.12+) focused on Go and C#/.NET development. It follows
LazyVim's layout: LazyVim defaults plus extras, with overrides and additions in `lua/plugins/`.

## Code Formatting

- Lua is formatted with `stylua` (`stylua.toml`: 2 spaces, 120 columns). Run `stylua .`.
- A few files (`legendary.lua`, `which-key.lua`, `keymaps.lua`) still use 4-space indentation; stylua will
  normalise them.

## Structure

- `init.lua` -- entry point, loads `config.lazy`
- `lua/config/lazy.lua` -- bootstraps lazy.nvim, imports `lazyvim.plugins` then `plugins`
- `lua/config/options.lua`, `keymaps.lua`, `autocmds.lua` -- overrides on top of LazyVim's defaults
- `lua/plugins/*.lua` -- one file per plugin or concern, each returning a spec table
- `lazyvim.json` -- enabled LazyVim extras (manage with `:LazyExtras`, not by importing them in `lazy.lua`)
- `lazy-lock.json` -- plugin lockfile, written by lazy.nvim

`defaults.lazy = false`: custom plugins load at startup unless the spec sets `ft`, `cmd`, `keys` or `event`.
External tools (LSP servers, formatters, debuggers) come from Mason and are found via `PATH`; do not hardcode
binary paths in specs.

## LazyVim Extras (`lazyvim.json`)

- `coding.yanky`
- `dap.core`
- `lang.go`, `lang.json`, `lang.markdown`
- `ai.supermaven`
- `test.core`
- `util.dot`

## Options (`lua/config/options.lua`)

- 4-space indentation (LazyVim default is 2), `smartindent`
- No wrap, `hlsearch` off, `scrolloff = 8`, colour column at 120, `cmdheight = 0`
- System clipboard (`unnamedplus`), persistent undo

## Keymaps (`lua/config/keymaps.lua`)

- `+` / `-` increment / decrement
- `<A-a>` select all
- Visual `J` / `K` move selected lines
- `J`, `<C-d>`, `<C-u>`, `n`, `N` keep the cursor in place or centred
- Visual `<leader>p` paste without overwriting the register
- `<leader>x` make current file executable
- `<leader>yp` yank the absolute file path
- `Q` disabled

## Plugins (`lua/plugins/`)

### C#/.NET

- `easy-dotnet.lua` -- easy-dotnet.nvim: build/test/run, `<C-p>` runs the project, checks outdated packages
  when a `.csproj` or `Directory.Packages.props` is opened or saved, and rewrites a file-scoped namespace on
  open to match the folder structure. Debugging via netcoredbg (auto-registered with nvim-dap).
- `roslyn.lua` -- roslyn.nvim as the C# language server. Server settings (inlay hints, code lens) go through
  `vim.lsp.config("roslyn", ...)`. Razor/CSHTML is handled by roslyn's cohosting; rzls.nvim is not used.
  Requires roslyn language server 5.12 or newer.
- `csharpier.lua` -- CSharpier as the conform.nvim formatter for `cs`, using conform's built-in definition.
- `neotest-csharp.lua` -- neotest-dotnet adapter, `<leader>t*` test keymaps, test projects detected by
  name (`Test`, `Tests`, `IntegrationTest`, `UnitTest`).
- `solution-explorer.lua` -- neo-tree hiding `bin/`, `obj/`, `.vs/`; `A` creates a new item via easy-dotnet;
  `<leader>se` / `<leader>st` / `<leader>sf`.
- `csharp-snippets.lua` -- LuaSnip C# snippets (class, interface, method, property, constructor, test
  method, API controller).

### Go

- `lang.go` extra provides gopls, delve, neotest-golang and nvim-dap-go.
- `go-enhanced.lua` -- gopls settings, gofumpt + goimports on save, go.nvim commands under `<leader>g*`,
  gopher.nvim tag/test generation under `<leader>gs*`.

### General

- `claude-code.lua` -- claudecode.nvim; `<leader>cc` toggle, `<leader>cf` focus.
- `snacks.lua` -- dashboard header, picker shows hidden files, `<leader>e` opens the explorer at the current
  file's directory (`A` creates a .NET item there).
- `flash.lua` -- flash.nvim configuration.
- `dev-tools.lua` -- rest.nvim (`.http`), vim-dadbod-ui (`<leader>Du`), nvim-jqx, diffview.nvim.
- `markdown.lua` -- marksman and markdownlint disabled, prettier for markdown, spell off.
- `legendary.lua` -- command palette (`<leader>fk`, `<C-S-p>`).
- `which-key.lua` -- group labels.
- `lualine.lua` -- clears `lualine_z`.
- `kanagawa.lua` -- colour scheme.

## Adding Plugins

1. Create a `.lua` file in `lua/plugins/` returning a spec table.
2. Prefer `opts` over `config`; use `optional = true` when extending a plugin that an extra may not enable.
3. Set `ft`, `cmd` or `keys` for language-specific plugins so they do not load at startup.
4. Local plugins live in `~/Dev/nvimplugins/` and are referenced with `dir = ...`.
