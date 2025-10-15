return {
  -- REST client for API testing
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run request under cursor", ft = "http" },
      { "<leader>rl", "<cmd>Rest run last<cr>", desc = "Run last request", ft = "http" },
    },
    opts = {
      skip_ssl_verification = false,
    },
  },
  
  -- Database client
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Toggle Database UI" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- JSON/YAML tools
  {
    "gennaro-tedesco/nvim-jqx",
    ft = { "json", "yaml" },
    keys = {
      { "<leader>jq", "<cmd>JqxList<cr>", desc = "JQ query", ft = { "json", "yaml" } },
    },
  },

  -- Git integration enhancements
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File History" },
    },
  },
}