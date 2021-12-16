local keymap = vim.api.nvim_set_keymap

local opts = { noremap = true }

-- Use alt + hjkl to resize windows
keymap('n', '<M-j>', ':resize -2<CR>', opts)
keymap('n', '<M-k>', ':resize +2<CR>', opts)
keymap('n', '<M-h>', ':vertical resize -2<CR>', opts)
keymap('n', '<M-l>', ':vertical resize +2<CR>', opts)

-- Better nav for omnicomplete
keymap('i', '<c-j>', '"<C-n>"', { expr = true, noremap = true })
keymap('i', '<c-k>', '"<C-p>"', { expr = true, noremap = true })

-- <TAB>: completion.
keymap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<TAB>"', { expr = true })

-- TAB in general mode will move to text buffer
keymap('n', '<TAB>', ':bnext<CR>', opts)
-- SHIFT-TAB will go back
keymap('n', '<S-TAB>', ':bprevious<CR>', opts)

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

keymap('n', '<C-t>', ':NvimTreeToggle<CR>', {})
keymap('n', '<C-r>', ':NvimTreeRefresh<CR>', {})
