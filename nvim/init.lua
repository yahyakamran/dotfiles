--Packer
vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-treesitter/nvim-treesitter'
    require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        highlight = {
        enable = true,
    }}
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'mbbill/undotree'
    use "machakann/vim-highlightedyank"
    use "tpope/vim-fugitive"
    use "Alligator/accent.vim"

    --harpoon
    use "nvim-lua/plenary.nvim"
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }
    -- LSP:
    use {
     'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'neovim/nvim-lspconfig'},
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},
    }}
end)

--Some VIM PRESETS
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guicursor = ""
vim.opt.wrap = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.list = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.swapfile = false
-- key maps
vim.g.mapleader = " "
vim.keymap.set('n','<leader>nw',vim.cmd.Sex)
vim.keymap.set('n','<leader>qw',vim.cmd.Ex)
--harpoon
vim.api.nvim_set_keymap("n", "<leader>hp", ":History<CR>", { noremap = true })
-- undotree
vim.keymap.set('n','<leader>u' , vim.cmd.UndotreeToggle)
--fzf finder
-- Open recently used files
vim.api.nvim_set_keymap("n", "<leader>fr", ":History<CR>", { noremap = true })
-- Open files in same directory as current file
vim.api.nvim_set_keymap("n", "<leader>ff", ":Files<CR>", { noremap = true })
--copy
vim.api.nvim_set_keymap("v", "gp", ": %w !xclip -i -sel c<CR><CR>", { noremap = true })
--Open all project files
vim.api.nvim_set_keymap("n", "<leader>fa", ":Files ~/projects/<CR>", { noremap = true })
--vim-fugitive
vim.keymap.set('n','<leader>gc' , vim.cmd.Git)
-- Open files in same directory as current file
--LSP CONFIG
local lsp_zero = require('lsp-zero')

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Enter>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

--harpoon
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-J>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-K>", function() harpoon:list():next() end)

--color schemes

vim.cmd[[let g:accent_colour = 'magenta']]
vim.cmd[[let g:accent_darken = 1]]

vim.cmd [[syntax on]]
vim.cmd [[set termguicolors]]
vim.cmd [[colorscheme accent]]

--vim color highlights

vim.cmd [[ highlight HighlightedyankRegion ctermbg=237 guibg=#707070]]
vim.cmd [[ highlight CurSearch ctermbg=237 guibg=#707070]]
vim.cmd [[ highlight IncSearch ctermbg=237 guibg=#707070]]


--netrw

vim.g.netrw_banner = 0



