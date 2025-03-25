return {
  "snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        pick = function(cmd, opts)
          return LazyVim.pick(cmd, opts)()
        end,
        header = [[
  ______               ___                 _                         
 / _____) _           / __)               | |                        
( (____ _| |_ _____ _| |__ _____ ____   __| |_____ ____   ____  ___  
 \____ (_   _) ___ (_   __|____ |  _ \ / _  (____ |  _ \ / _  |/ _ \ 
 _____) )| |_| ____| | |  / ___ | | | ( (_| / ___ | | | ( (_| | |_| |
(______/  \__)_____) |_|  \_____|_| |_|\____\_____|_| |_|\___ |\___/ 
                                                        (_____|      
 ]],
        -- stylua: ignore
        ---@type snacks.dashboard.Item[]
        -- keys = {
        --   { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        --   { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        --   { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        --   { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        --   { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
        --   { icon = " ", key = "s", desc = "Restore Session", section = "session" },
        --   { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
        --   { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
        --   { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        -- },
      },
    },
    explorer = {},
    picker = {
      sources = {
        files = {
          hidden = true,
          follow = true,
        },
      },
      formatters = {
        file = {
          filename_first = true,
        },
      },
    },
  },
}
