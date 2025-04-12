return {
  dir = "~/Dev/nvimplugins/easy-dotnet.nvim", -- Required
  name = "easy-dotnet", -- Optional
  config = function()
    local dotnet = require("easy-dotnet")
    dotnet.setup(
      {
        mappings = {
          run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
          filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
          debug_test = { lhs = "<leader>d", desc = "debug test" },
          go_to_file = { lhs = "g", desc = "got to file" },
          run_all = { lhs = "<leader>R", desc = "run all tests" },
          run = { lhs = "<leader>r", desc = "run test" },
          peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
          expand = { lhs = "o", desc = "expand" },
          expand_node = { lhs = "E", desc = "expand node" },
          expand_all = { lhs = "-", desc = "expand all" },
          collapse_all = { lhs = "W", desc = "collapse all" },
          close = { lhs = "q", desc = "close testrunner" },
          refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
        },
        --- Optional table of extra args e.g "--blame crash"
        additional_args = {},
      },
      -- Example keybinding
      vim.keymap.set("n", "<C-p>", function()
        dotnet.run()
      end)
    )
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      pattern = { "Directory.Packages.props", "*.csproj" },
      callback = function()
        dotnet.outdated()
      end,
    })
  end,
}
