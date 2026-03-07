return {
  -- Disable marksman LSP (doesn't work on NixOS - dynamically linked binary)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = { enabled = false },
      },
    },
  },

  -- Disable markdownlint diagnostics entirely
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },

  -- Disable markdownlint-cli2 as formatter too
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
      },
    },
  },

  -- Disable spell checking for markdown (LazyVim enables it by default)
  {
    "LazyVim/LazyVim",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.opt_local.spell = false
        end,
      })
    end,
  },

  -- Fix markdown-preview build for NixOS (default build downloads a dynamic binary)
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
  },
}
