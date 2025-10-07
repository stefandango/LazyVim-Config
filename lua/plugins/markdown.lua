return {
  -- Configure marksman LSP for markdown with selective warning suppression
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          settings = {
            marksman = {
              -- Keep completion but reduce noise
              completion = {
                wiki = {
                  enabled = true,
                },
              },
            },
          },
          -- Filter out common false positives
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              if result and result.diagnostics then
                -- Filter out specific diagnostic messages that are commonly unhelpful
                result.diagnostics = vim.tbl_filter(function(diagnostic)
                  local message = diagnostic.message:lower()
                  -- Common false positives to ignore:
                  return not (
                    message:match("md013") or               -- Line length warnings
                    message:match("line too long") or       -- Alternative line length message
                    message:match("md001") or               -- Header levels
                    message:match("md003") or               -- Header style
                    message:match("md012") or               -- Multiple consecutive blank lines
                    message:match("md022") or               -- Headers should be surrounded by blank lines
                    message:match("md025") or               -- Multiple top level headers
                    message:match("md026") or               -- Trailing punctuation in header
                    message:match("link destination") or    -- Broken link warnings for external content
                    message:match("reference not found") or -- Missing references in copied content
                    message:match("unused reference")       -- Unused references
                  )
                end, result.diagnostics)
              end
              -- Call the default handler
              vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
            end,
          },
        },
      },
    },
  },

  -- Keep other markdown functionality but reduce diagnostic noise
  {
    "neovim/nvim-lspconfig", 
    opts = function()
      -- Set up autocmd to reduce diagnostic noise for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          -- Reduce update frequency to avoid constant warnings while typing
          vim.diagnostic.config({
            update_in_insert = false,
            virtual_text = {
              severity = { min = vim.diagnostic.severity.WARN }, -- Only show warnings and errors
            },
          })
        end,
      })
    end,
  },
}