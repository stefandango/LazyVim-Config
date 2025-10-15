return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      -- Flash configuration
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        -- search/jump in all windows
        multi_window = true,
        -- search direction
        forward = true,
        -- when `false`, find only matches in the given direction
        wrap = true,
        -- Each mode will take ignorecase and smartcase into account.
        mode = "exact",
        -- behave like `incsearch`
        incremental = false,
      },
      jump = {
        -- save location in the jumplist
        jumplist = true,
        -- jump position
        pos = "start",
        -- automatically jump when there is only one match
        autojump = false,
      },
      label = {
        -- allow uppercase labels
        uppercase = true,
        -- add a label for the first match in the current window.
        current = true,
        -- show the label after the match
        after = true,
        -- show the label before the match
        before = false,
        -- position of the label extmark
        style = "overlay",
      },
      modes = {
        -- a regular search with `/` or `?`
        search = {
          enabled = true,
        },
        -- `f`, `F`, `t`, `T`, `;` and `,` motions
        char = {
          enabled = true,
          -- hide after jump when not using jump labels
          autohide = false,
          -- jump labels for f/F/t/T motions
          jump_labels = false,
          -- by default all keymaps are enabled, but you can disable some of them,
          -- by removing them from the list.
          keys = { "f", "F", "t", "T", ";", "," },
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
}
