return {
  -- Auto-format Go files on save with gofumpt
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        goimports = "gopls",
        fillstruct = "gopls",
        dap_debug = true,
        dap_debug_gui = true,
        dap_debug_delve = vim.fn.expand("~/go/bin/dlv"),
        test_runner = "go",
        run_in_floaterm = true,
        luasnip = false, -- Disable to avoid ts_utils deprecation errors
        lsp_cfg = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
          settings = {
            gopls = {
              experimentalPostfixCompletions = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
              gofumpt = true,
              usePlaceholders = true,
              completeUnimported = true,
              matcher = "fuzzy",
              deepCompletion = true,
            },
          },
        },
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    keys = {
      { "<leader>gt", "<cmd>GoTest<cr>", desc = "Go Test", ft = "go" },
      { "<leader>gT", "<cmd>GoTestFunc<cr>", desc = "Go Test Function", ft = "go" },
      { "<leader>gc", "<cmd>GoCoverage<cr>", desc = "Go Coverage", ft = "go" },
      { "<leader>gr", "<cmd>GoRun<cr>", desc = "Go Run", ft = "go" },
      { "<leader>gb", "<cmd>GoBuild<cr>", desc = "Go Build", ft = "go" },
      { "<leader>gi", "<cmd>GoImport<cr>", desc = "Go Import", ft = "go" },
      { "<leader>gf", "<cmd>GoFmt<cr>", desc = "Go Format", ft = "go" },
      { "<leader>gs", "<cmd>GoFillStruct<cr>", desc = "Go Fill Struct", ft = "go" },
      { "<leader>ge", "<cmd>GoIfErr<cr>", desc = "Go If Err", ft = "go" },
      { "<leader>gat", "<cmd>GoAddTag<cr>", desc = "Go Add Tags", ft = "go" },
      { "<leader>grt", "<cmd>GoRmTag<cr>", desc = "Go Remove Tags", ft = "go" },
      { "<leader>gmt", "<cmd>GoModTidy<cr>", desc = "Go Mod Tidy", ft = "go" },
      { "<leader>gD", "<cmd>GoDoc<cr>", desc = "Go Doc", ft = "go" },
    },
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    keys = {
      { "<leader>gsj", "<cmd>GoTagAdd json<cr>", desc = "Add JSON tags", ft = "go" },
      { "<leader>gsy", "<cmd>GoTagAdd yaml<cr>", desc = "Add YAML tags", ft = "go" },
      { "<leader>gst", "<cmd>GoTestsAll<cr>", desc = "Generate tests for all funcs", ft = "go" },
      { "<leader>gsf", "<cmd>GoTestsFunc<cr>", desc = "Generate test for current func", ft = "go" },
      { "<leader>gse", "<cmd>GoTestsExp<cr>", desc = "Generate test for exported funcs", ft = "go" },
    },
  },
}