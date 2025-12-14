return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        -- Neovim/Lua
        "lua",
        "vim",
        "vimdoc",

        -- Web (your core stack)
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",

        -- Data / config
        "json",
        "yaml",
        "toml",

        -- Docs / writing
        "markdown",
        "markdown_inline",

        -- Shell / tooling
        "bash",

        -- Backend / misc (common in your workflow)
        "c_sharp",
        "sql",
      },
      auto_install = true,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

