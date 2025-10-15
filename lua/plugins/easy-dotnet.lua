return {
  "GustavEikaas/easy-dotnet.nvim",
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

    -- Auto-fix namespace based on folder structure
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "*.cs",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filepath = vim.api.nvim_buf_get_name(bufnr)

        -- Find the .csproj file
        local dir = vim.fs.dirname(filepath)
        local csproj = vim.fs.find(function(name)
          return name:match("%.csproj$")
        end, { upward = true, path = dir })[1]

        if not csproj then return end

        -- Get project name from .csproj filename
        local project_name = vim.fn.fnamemodify(csproj, ":t:r")
        local project_dir = vim.fs.dirname(csproj)

        -- Calculate relative path from project to file
        local rel_path = filepath:sub(#project_dir + 2) -- +2 to remove leading slash
        local path_parts = vim.split(rel_path, "/")

        -- Remove filename from path
        table.remove(path_parts, #path_parts)

        -- Build namespace
        local namespace = project_name
        if #path_parts > 0 then
          namespace = namespace .. "." .. table.concat(path_parts, ".")
        end

        -- Check if first line has incorrect namespace
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 5, false)
        for i, line in ipairs(lines) do
          if line:match("^namespace%s+") then
            local current_ns = line:match("^namespace%s+([^;{%s]+)")
            if current_ns ~= namespace then
              -- Replace the namespace
              vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, { "namespace " .. namespace .. ";" })
              vim.notify("Fixed namespace: " .. current_ns .. " → " .. namespace, vim.log.levels.INFO)
            end
            break
          end
        end
      end,
    })
  end,
}
