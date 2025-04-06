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
