return {
  -- Disabled due to compatibility issues with netcoredbg
  --[[
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint", ft = "cs" },
      { "<F5>", function() require("dap").continue() end, desc = "Continue/Start Debug", ft = "cs" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step Over", ft = "cs" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step Into", ft = "cs" },
      { "<S-F11>", function() require("dap").step_out() end, desc = "Step Out", ft = "cs" },
      { "<leader>dR", function() require("dap").repl.open() end, desc = "Open REPL", ft = "cs" },
      { "<leader>dL", function() require("dap").run_last() end, desc = "Run Last", ft = "cs" },
      { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle Debug UI", ft = "cs" },
      { "<leader>dH", function() require("dap.ui.widgets").hover() end, desc = "Debug Hover", ft = "cs" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      -- Setup DAP UI
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      -- Auto open/close DAP UI (with defer to avoid startup issues)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        vim.schedule(function()
          dapui.open()
        end)
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        vim.schedule(function()
          dapui.close()
        end)
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        vim.schedule(function()
          dapui.close()
        end)
      end

      -- .NET Core debugger configuration
      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
        args = { "--interpreter=vscode" },
      }
      
      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            -- First try to find the DLL automatically
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            local debug_path = vim.fn.getcwd() .. "/bin/Debug"
            
            -- Look for any .dll in Debug folder
            local dll_files = vim.fn.glob(debug_path .. "/**/*.dll", false, true)
            
            if #dll_files > 0 then
              -- Filter out system DLLs, prefer the project DLL
              for _, dll in ipairs(dll_files) do
                if string.match(dll, project_name) then
                  return dll
                end
              end
              -- If no project-named DLL, return the first one
              return dll_files[1]
            end
            
            -- Fallback to manual input
            return vim.fn.input("Path to dll: ", debug_path .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          console = "integratedTerminal",
          env = {
            DOTNET_ROOT = "/usr/local/share/dotnet"
          },
        },
        {
          type = "coreclr",
          name = "dotnet run",
          request = "launch",
          program = function()
            -- Find the project file
            local csproj_files = vim.fn.glob("*.csproj", false, true)
            if #csproj_files == 0 then
              vim.notify("No .csproj file found in current directory", vim.log.levels.ERROR)
              return nil
            end
            
            -- Build the project first
            vim.fn.system("dotnet build")
            
            -- Get the target framework and project name
            local project_name = vim.fn.fnamemodify(csproj_files[1], ":t:r")
            
            -- Look for the executable in bin/Debug
            local exe_patterns = {
              "bin/Debug/*//" .. project_name .. ".dll",
              "bin/Debug/*//" .. project_name,
              "bin/Debug/**/" .. project_name .. ".dll"
            }
            
            for _, pattern in ipairs(exe_patterns) do
              local files = vim.fn.glob(pattern, false, true)
              if #files > 0 then
                return files[1]
              end
            end
            
            vim.notify("Could not find executable. Make sure project is built.", vim.log.levels.ERROR)
            return nil
          end,
          cwd = "${workspaceFolder}",
          stopAtEntry = false,
          console = "integratedTerminal",
        },
        {
          type = "coreclr",
          name = "Simple Launch",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
          args = {},
          cwd = vim.fn.getcwd(),
          stopAtEntry = true,
          console = "integratedTerminal",
          justMyCode = false,
          symbolSearchPaths = {
            vim.fn.getcwd() .. "/bin/Debug",
          },
          sourceFileMap = {},
        },
        {
          type = "coreclr",
          name = "Minimal Test",
          request = "launch",
          program = "/Users/stefan/debug-test/bin/Debug/net8.0/debug-test.dll",
          cwd = "/Users/stefan/debug-test",
          stopAtEntry = false,
        },
        {
          type = "coreclr",
          name = "attach - netcoredbg",
          request = "attach",
          processId = function()
            return require("dap.utils").pick_process()
          end,
        },
      }

      -- Virtual text configuration
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
      })
    end,
  },
  --]]
}