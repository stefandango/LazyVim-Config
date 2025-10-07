return {
  "coder/claudecode.nvim",
  lazy = false,
  dependencies = {
    "folke/snacks.nvim",
  },
  opts = {
    terminal_cmd = vim.fn.expand("~/.claude/local/claude"),
  },
  keys = {
    {
      "<leader>cc",
      function()
        local ok, err = pcall(function()
          vim.cmd("ClaudeCode")
        end)
        if not ok then
          vim.notify("ClaudeCode error: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
      desc = "Toggle Claude Code",
    },
    {
      "<leader>cf",
      "<cmd>ClaudeCodeFocus<cr>",
      desc = "Focus Claude Code",
    },
  },
}