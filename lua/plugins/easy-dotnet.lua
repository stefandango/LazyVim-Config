return {
  dir = "~/Dev/nvimplugins/easy-dotnet.nvim", -- Required
  name = "easy-dotnet", -- Optional
  config = function()
    require("easy-dotnet").setup()
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      pattern = { "Directory.Packages.props", "*.csproj" },
      callback = function()
        require("easy-dotnet").outdated()
      end,
    })
  end,
}
-- return {
--   "GustavEikaas/easy-dotnet.nvim",
--   dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
--   config = function()
--     local function get_secret_path(secret_guid)
--       local path = ""
--       local home_dir = vim.fn.expand("~")
--       if require("easy-dotnet.extensions").isWindows() then
--         local secret_path = home_dir
--           .. "\\AppData\\Roaming\\Microsoft\\UserSecrets\\"
--           .. secret_guid
--           .. "\\secrets.json"
--         path = secret_path
--       else
--         local secret_path = home_dir .. "/.microsoft/usersecrets/" .. secret_guid .. "/secrets.json"
--         path = secret_path
--       end
--       return path
--     end
--     local dotnet = require("easy-dotnet")
--     dotnet.setup({})
--   end,
-- }
