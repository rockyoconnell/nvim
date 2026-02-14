-- =====================================================
-- Baseline options
-- =====================================================
vim.opt.relativenumber = true
vim.opt.smarttab = true
vim.opt.indentexpr = ""
-- vim.opt.showmatch = true
-- vim.opt.matchtime = 1
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.wrap = false
vim.opt.conceallevel = 0
vim.opt.termguicolors = true
vim.o.isfname = table.concat({ vim.o.isfname, "(", ")" }, ",")

require("config.keymaps")

-- =====================================================
-- lazy.nvim bootstrap
-- =====================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- =====================================================
-- lazy.nvim setup (no plugins yet)
-- =====================================================
require("lazy").setup("plugins")

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shellslash = true

  -- Use a Windows-native shell for :! commands
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellredir = "2>&1 | Out-File -Encoding UTF8 %s"
  vim.opt.shellpipe  = "2>&1 | Tee-Object %s"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end
