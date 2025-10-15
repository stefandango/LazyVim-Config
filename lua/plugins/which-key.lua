return {
    "folke/which-key.nvim",
    opts = {
        delay = 300, -- delay before popup appears (ms)
        -- Add custom groups to organize your keymaps
        spec = {
            { "<leader>d", group = "dotnet" },
            { "<leader>c", group = "code" },
            { "<leader>s", group = "solution/search" },
            { "<leader>t", group = "test/terminal" },
            { "<leader>f", group = "find/file" },
            { "<leader>g", group = "git" },
            { "<leader>u", group = "ui" },
            { "<leader>w", group = "windows" },
            { "<leader>x", group = "diagnostics/quickfix" },
        },
    },
}
