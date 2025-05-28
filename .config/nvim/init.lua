local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
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
vim.opt.clipboard = "unnamedplus"

vim.keymap.set('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })

-- Movement remaps (Normal, Visual, Operator-pending modes)
vim.keymap.set({'n', 'v', 'o'}, 'n', 'j', { noremap = true })  -- Down
vim.keymap.set({'n', 'v', 'o'}, 'e', 'k', { noremap = true })  -- Up
vim.keymap.set({'n', 'v', 'o'}, 'i', 'l', { noremap = true })  -- Right

-- Search Next Previous
vim.keymap.set('n', 'k', 'n', { noremap = true })  -- Search next
vim.keymap.set('n', 'K', 'N', { noremap = true })  -- Search previous

-- Insert mode adjustments
vim.keymap.set('n', 'u', 'i', { noremap = true })  -- Insert mode
vim.keymap.set('n', 'U', 'I', { noremap = true })  -- Insert at beginning

-- Undo & redo
vim.keymap.set('n', 'j', 'u', { noremap = true })  -- Undo
vim.keymap.set('n', 'J', '<C-r>', { noremap = true })  -- Redo

-- Open new lines
vim.keymap.set('n', 'y', 'o', { noremap = true })  -- Open new line below
vim.keymap.set('n', 'Y', 'O', { noremap = true })  -- Open new line above

require("vim-options")
require("lazy").setup("plugins")


