return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "Issafalcon/neotest-dotnet",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run Test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run Test File" },
      { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Test" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test Summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test Output" },
      { "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle Test Panel" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Watch Test File" },
      { "<leader>tc", function() require("neotest").run.run({suite = false}) end, desc = "Run Current Test" },
      { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last Test" },
      { "<leader>ta", function() require("neotest").run.run({suite = true}) end, desc = "Run All Tests" },
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      opts.adapters["neotest-dotnet"] = {
        dap = { 
          justMyCode = false,
          console = "integratedTerminal",
        },
        discovery_root = "solution",
        dotnet_additional_args = {
          verbosity = "normal",
        },
        is_test_project = function(path)
          local function contains(t, val)
            for _, v in ipairs(t) do
              if string.find(val, v, 1, true) then
                return true
              end
            end
            return false
          end
          
          return contains({
            "test",
            "Test",
            "Tests",
            "IntegrationTest",
            "UnitTest"
          }, path)
        end,
      }
      return opts
    end,
  },
}