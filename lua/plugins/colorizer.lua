return {
    "norcalli/nvim-colorizer.lua",
    opts = { },
    config = function()
        vim.api.nvim_create_user_command('Ct', 'ColorizerToggle', {})
    end,
}
