--
-- Options
--

local opt = vim.opt

-- Line numbers
-- Show line numbers
opt.number = true
-- User relative line numbers
opt.relativenumber = false

-- Text width column
opt.colorcolumn = "80"

-- Tabs
-- use spaces instead of tabs
opt.expandtab = true
-- indent 2 spaces by default
opt.tabstop = 2
opt.softtabstop = 0
opt.shiftwidth = 0

--
-- Keymaps
--

local map = vim.keymap.set

map("n", "<C-y>", "<Cmd>%y+<Cr>", { desc = "Copy current buffer to system clipboard" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
