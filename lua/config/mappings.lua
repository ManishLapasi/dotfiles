vim.g.mapleader = " "
local keymap = vim.keymap

-- universal clipboard
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- tab indents
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- shifting between files
keymap.set("n", "<leader><Right>", ":bnext<CR>")
keymap.set("n", "<leader><Left>", ":bprev<CR>")

-- telescope
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")

-- tree
keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
keymap.set("n", "<C-[>", ":NvimTreeFocus<CR>")

-- buffer nav
keymap.set("n", "<leader>d", ":bd<CR>")

-- show diagnostics in floating window
keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
