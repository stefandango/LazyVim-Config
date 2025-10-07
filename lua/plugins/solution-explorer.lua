return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = false,
        hide_by_name = {
          "bin",
          "obj", 
          ".vs",
          ".vscode",
          "node_modules",
          ".git",
        },
        hide_by_pattern = {
          "*.csproj.user",
          "*.suo",
          "*.cache",
        },
      }
      opts.filesystem.follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      }
      opts.filesystem.use_libuv_file_watcher = true
      return opts
    end,
    keys = {
      { "<leader>se", "<cmd>Neotree filesystem reveal left<cr>", desc = "Solution Explorer" },
      { "<leader>st", "<cmd>Neotree toggle<cr>", desc = "Toggle Solution Explorer" },
      { "<leader>sf", "<cmd>Neotree focus<cr>", desc = "Focus Solution Explorer" },
    },
  },
}