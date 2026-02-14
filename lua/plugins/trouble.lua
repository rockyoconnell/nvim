return {
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)"
            },
            {
                "<leader>tq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)"
            }
        }
    },
}
