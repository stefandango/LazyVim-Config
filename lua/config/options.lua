-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--

-- vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.undofile = true

-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Use system clipboard for all operations
vim.opt.clipboard = "unnamedplus"

vim.opt.colorcolumn = "120"
vim.opt.cmdheight = 0

-- Swap file handling to prevent E325 errors with file explorers
vim.opt.shortmess:append("A") -- Don't give the "ATTENTION" message when an existing swap file is found
vim.opt.autoread = true -- Automatically read file when changed outside of Vim

-- prune legacy dein.vim paths that can confuse tooling like Supermaven
local legacy_dein = vim.fn.expand("~/.cache/nvim/dein.vim")
if vim.fn.isdirectory(legacy_dein) == 0 then
  pcall(function()
    vim.opt.runtimepath:remove(legacy_dein)
    vim.opt.packpath:remove(legacy_dein)
  end)
end
