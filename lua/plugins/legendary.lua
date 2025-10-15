return {
    "mrjones2014/legendary.nvim",
    priority = 10000,
    lazy = false,
    keys = {
        { "<leader>fk", "<cmd>Legendary<cr>", desc = "Find Keymaps" },
        { "<C-S-p>", "<cmd>Legendary<cr>", desc = "Command Palette" },
    },
    opts = {
        extensions = {
            lazy_nvim = true,
            which_key = true,
        },
    },
}
