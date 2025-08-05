return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor" },
    dependencies = {
      {
        -- By loading as a dependencies, we ensure that we are available to set
        -- the handlers for roslyn
        "tris203/rzls.nvim",
        config = function()
          ---@diagnostic disable-next-line: missing-fields
          require("rzls").setup({})
        end,
      },
    },
    keys = {
      { "<leader>cr", function() vim.lsp.buf.rename() end, desc = "Rename Symbol", ft = "cs" },
      { "<leader>ca", function() vim.lsp.buf.code_action() end, desc = "Code Actions", ft = "cs" },
      { "<leader>cf", function() vim.lsp.buf.format() end, desc = "Format Document", ft = "cs" },
      { "gI", function() vim.lsp.buf.implementation() end, desc = "Go to Implementation", ft = "cs" },
      { "gr", function() vim.lsp.buf.references() end, desc = "Find References", ft = "cs" },
      { "K", function() vim.lsp.buf.hover() end, desc = "Hover Documentation", ft = "cs" },
      { "<leader>ch", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, desc = "Toggle Inlay Hints", ft = "cs" },
      { "<leader>cs", function() vim.lsp.buf.signature_help() end, desc = "Signature Help", ft = "cs" },
    },
    config = function()
      require("roslyn").setup({
        args = {
          "--stdio",
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          "--razorSourceGenerator=" .. vim.fs.joinpath(
            vim.fn.stdpath("data") --[[@as string]],
            "mason",
            "packages",
            "roslyn",
            "libexec",
            "Microsoft.CodeAnalysis.Razor.Compiler.dll"
          ),
          "--razorDesignTimePath=" .. vim.fs.joinpath(
            vim.fn.stdpath("data") --[[@as string]],
            "mason",
            "packages",
            "rzls",
            "libexec",
            "Targets",
            "Microsoft.NET.Sdk.Razor.DesignTime.targets"
          ),
        },
        ---@diagnostic disable-next-line: missing-fields
        handlers = require("rzls.roslyn_handlers"),
        settings = {
            ["csharp|inlay_hints"] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,

              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|code_lens"] = {
              dotnet_enable_references_code_lens = true,
            },
          },
      })
    end,
    init = function()
      -- we add the razor filetypes before the plugin loads
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    end,
  },
}
