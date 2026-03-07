return {
    {
        "mfussenegger/nvim-dap",
        optional = true,
        config = function()
            local dap = require("dap")

            -- Configure Go debugging with explicit Delve path
            dap.adapters.go = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.expand("~/go/bin/dlv"),
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                },
            }

            dap.configurations.go = {
                {
                    type = "go",
                    name = "Debug",
                    request = "launch",
                    program = "${file}",
                },
                {
                    type = "go",
                    name = "Debug Package",
                    request = "launch",
                    program = "${fileDirname}",
                },
                {
                    type = "go",
                    name = "Debug Test",
                    request = "launch",
                    mode = "test",
                    program = "${file}",
                },
                {
                    type = "go",
                    name = "Debug (Arguments)",
                    request = "launch",
                    program = "${file}",
                    args = function()
                        local args_string = vim.fn.input("Arguments: ")
                        return vim.split(args_string, " +")
                    end,
                },
            }
        end,
    },
}
