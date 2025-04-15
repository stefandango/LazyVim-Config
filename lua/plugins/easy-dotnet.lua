return {
  dir = "~/Dev/nvimplugins/easy-dotnet.nvim", -- Required
  name = "easy-dotnet", -- Optional
  config = function()
    local dotnet = require("easy-dotnet")
    dotnet.setup(
      {
        ---@param action "test" | "restore" | "build" | "run" | "watch"
        terminal = function(path, action, args)
          local commands = {
            run = function()
              return string.format("dotnet run --project %s %s", path, args)
            end,
            test = function()
              return string.format("dotnet test %s %s", path, args)
            end,
            restore = function()
              return string.format("dotnet restore %s %s", path, args)
            end,
            build = function()
              return string.format("dotnet build %s %s", path, args)
            end,
            watch = function()
              return string.format("dotnet watch --project %s %s", path, args)
            end,
          }

          local command = commands[action]() .. "\r"
          vim.cmd("split")
          vim.cmd("term " .. command)
          vim.cmd("startinsert")

          local current_buf = vim.api.nvim_get_current_buf()
          vim.api.nvim_buf_set_keymap(current_buf, "n", "<C-q>", ":close<CR>", { noremap = true, silent = true })
          vim.api.nvim_buf_set_keymap(current_buf, "t", "<C-c>", "<C-c>", { noremap = true, silent = true })
        end,
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
