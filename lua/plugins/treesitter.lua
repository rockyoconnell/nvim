return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "javascript",
        "typescript",
        "tsx",
        "css",
        "c_sharp",
      },
      indent = { enable = true },
      highlight = { enable = true },
      auto_install = false,
      sync_install = false,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevel = 99
      -- vim.opt.foldlevelstart = 4
      vim.opt.foldtext = ""
    end,
  }
}

