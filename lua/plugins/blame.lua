return {
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function()
            require('blame').setup {}
            vim.api.nvim_create_user_command('Bt', 'BlameToggle', {})
        end,
    },
}
