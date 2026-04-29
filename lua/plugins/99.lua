return {
    "ThePrimeagen/99",
    config = function()
        local _99 = require("99")

        _99.setup({
            provider = _99.Providers.OpenCodeProvider,
            model = "github-copilot/gpt-5.3-codex",
            tmp_dir = "~/Tmp",
        })

        vim.keymap.set("v", "<leader>nv", function()
            _99.visual()
        end, { desc = "99 Visual" })

        vim.keymap.set("n", "<leader>nw", function()
            _99.Extensions.Worker.set_work()
        end, { desc = "99 Set Work" })

        vim.keymap.set("n", "<leader>ns", function()
            _99.Extensions.Worker.search()
        end, { desc = "99 Worker Search" })

        vim.keymap.set("n", "<leader>nc", function()
            _99.stop_all_requests()
        end, { desc = "99 Stop Requests" })

        vim.keymap.set("n", "<leader>no", function()
            _99.open()
        end, { desc = "99 Open" })

        vim.keymap.set("n", "<leader>nl", function()
            _99.view_logs()
        end, { desc = "99 View Logs" })

    end
}
 
