return {
    "shortcuts/no-neck-pain.nvim",
    config = function()
        require("no-neck-pain").setup({
            width = 120,
            autocmds = {
                enableOnVimEnter = true,
                enableOnTabEnter = true,
                disableOnVimLeave = true,
            },
            buffers = {
                scratchPad = {
                    -- set to `false` to
                    -- disable auto-saving
                    enabled = false,
                    -- set to `nil` to default 
                    -- to current working directory
                    location = "~/Documents/Scratch",
                },
                bo = {
                    filetype = "md"
                },
            },
        })
    end
}
