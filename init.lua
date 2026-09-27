vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.list = true
vim.o.mouse = "a"
vim.o.nu = true
vim.o.rnu = true
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add{ gh('folke/tokyonight.nvim') }
---@diagnostic disable-next-line: missing-fields
require('tokyonight').setup {
    styles = {
	comments = { italic = false }, -- Disable italics in comments
    },
}

vim.cmd("colorscheme tokyonight-moon")

vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require('mason').setup {}

  -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
  require('mason-lspconfig').setup {
    automatic_enable = true, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
  }

vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }
-- Ensure basic parsers are installed
local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
require('nvim-treesitter').install(parsers)

vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
    keymap = {
	-- All presets have the following mappings:
	-- <tab>/<s-tab>: move to right/left of your snippet expansion
	-- <c-space>: Open menu or open docs if already open
	-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
	-- <c-e>: Hide menu
	-- <c-k>: Toggle signature help
	--
	-- See `:help blink-cmp-config-keymap` for defining your own keymap
	preset = 'default',

	-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
	--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
	-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	-- Adjusts spacing to ensure icons are aligned
	nerd_font_variant = 'mono',
    },

    completion = {
	-- By default, you may press `<c-space>` to show the documentation.
	-- Optionally, set `auto_show = true` to show the documentation after a delay.
	documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },

    sources = {
	default = { 'lsp', 'path', 'snippets' },
    },

    -- snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
}
