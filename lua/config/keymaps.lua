-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
--keymap.del("n", "<C-a")
keymap.set("n", "<A-a>", "gg<S-v>G", opts)

-- Move selection
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected down" })

-- Cursor placement
keymap.set("n", "J", "mzJ`z", { desc = "[OVERWRITE] - makes cursor stay en save position when using J in normal mode" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "C-d - keeps cursor in middle of screen if possible" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "C-u - keeps cursor in middle of screen if possible" })
keymap.set("n", "n", "nzzzv", { desc = "Keeps cursor in middle when searching" })
keymap.set("n", "N", "Nzzzv", { desc = "Keeps cursoer in middle when searching" })

-- greatest remap ever
keymap.set("x", "<leader>p", '"_dP', { desc = "Keeps current buffer when pasting" })

keymap.set("n", "Q", "<nop>", { desc = "[OVERWRITE] Dont use..." })
--keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open other tmux session." })

-- Command to make current file executable..
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "set chmod+x for current file..", silent = true })
