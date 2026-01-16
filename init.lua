vim.g.mapleader = " " -- Leader: space

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = false

-- Visual aid
vim.opt.cursorcolumn = false
vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Gutter
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.signcolumn = "yes"

-- Visual
vim.opt.termguicolors = true
vim.o.winborder = 'single'

vim.opt.undofile = true

-- Keymaps:

vim.keymap.set('n', '<leader>o', '<cmd>update<CR> <cmd>source<CR>')            -- Source File
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)                          -- Format buffer
vim.keymap.set('n', '<leader>f', function() require('fff').find_files() end)   -- FFFFiles
vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end)              -- Mini file explorer
vim.keymap.set('n', 'U', '<cmd>redo<CR>')                                      -- Redo as in Helix
vim.keymap.set('n', ',', '<cmd>noh<CR>')

-- Helix-like yanking and pasting
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y')      -- Yank selected to system clipboard
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>yy', '"+yy')    -- Yank line to system clipboard
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p')      -- Paste from system clipboard
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>P', '"+P')      -- Paste before from system clipboard

-- Todo-comments
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

-- Treesitter folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
function _G.CustomFoldText()
	return vim.fn.getline(vim.v.foldstart) .. ' ... ' .. vim.fn.getline(vim.v.foldend):gsub("^%s*", "")
end

vim.opt.foldtext = 'v:lua.CustomFoldText()'

-- Whitespace characters
vim.opt.list = false
vim.opt.listchars = {
	tab = "» ",
	lead = "·",
}

-- Packages

local function gh(shortened)
	return "https://github.com/" .. shortened
end

vim.pack.add({
	-- Themes
	gh("rose-pine/neovim"),
	gh("datsfilipe/vesper.nvim"),
	gh("vague-theme/vague.nvim"),
	-- Treesitter
	gh("nvim-treesitter/nvim-treesitter"),
	-- Completions
	gh("saghen/blink.cmp"),                     -- Autocomplete
	gh("rafamadriz/friendly-snippets"),         -- Snippets
	gh("tpope/vim-endwise"),                    -- Complete `end` & `done`
	-- Mini
	gh("nvim-mini/mini.nvim"),
	-- Visual help
	gh("nvim-lualine/lualine.nvim"),            -- Status line
	gh("dmtrKovalenko/fff.nvim"),               -- Fuzzy file search
	gh("folke/which-key.nvim"),                 -- Which-key as in Helix
	gh("folke/todo-comments.nvim"),             -- Comment highlighting
	gh("brenoprata10/nvim-highlight-colors"),   -- CSS Color highlighting
	gh("lukas-reineke/indent-blankline.nvim"),  -- Indentation guides
	gh("folke/twilight.nvim"),                  -- Focus mode
	gh("lewis6991/gitsigns.nvim"),							-- Git gutters
	gh("rachartier/tiny-glimmer.nvim"),         -- Visual feedback on common actions
	-- gh("vzze/cmdline.nvim"),                    -- Comand line suggestions as in Helix
	-- Misc
	gh("vyfor/cord.nvim"),                      -- Discord RPC
	gh("MeanderingProgrammer/render-markdown.nvim"),
	-- Deps
	gh("nvim-tree/nvim-web-devicons"),          -- Icons
	gh("rachartier/tiny-devicons-auto-colors.nvim"),
	gh("folke/snacks.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("MunifTanjim/nui.nvim"),
})

local logo = "    ██████    ██████        \n  ██      ████      ██      \n██  ████      ████    ██    \n██        ██          ██    \n██                    ██    \n  ██                ██      \n██                    ██    \n██                    ██    \n  ██    ██    ██    ██      \n██    ████    ████    ██    \n██████  ██    ██  ██████    \n          ████              \n"

-- Mini
require('mini.cursorword').setup() -- Highlight the word under the cursor
require('mini.tabline').setup()    -- Buffer and Tab line
require('mini.surround').setup()   -- [s]urround
require('mini.comment').setup()    -- [g][c]omment
require('mini.bracketed').setup()  -- `]` and `[` Navigation
require('mini.jump').setup()       -- [f] and [t] Jumping
require('mini.files').setup()      -- File explorer
require('mini.pairs').setup()      -- Autopair
require('mini.pick').setup()       -- Multipurpose picker
require('mini.extra').setup()      -- Extras for Pick
require('mini.move').setup()       -- Move stuff with <A>
require('mini.ai').setup()         -- [a]round & [i]nside
require('mini.git').setup()        -- Git
-- require('mini.clue').setup()       -- Which-key
require('mini.starter').setup({    -- Greeter
	header = logo
})


require('tiny-devicons-auto-colors').setup()
require("ibl").setup({
	indent = {
		char = "┊"
	}
})

require('tiny-glimmer').setup({
	overwrite = {
		undo = {enabled = true},
		redo = {enabled = true}
	}
})
require('todo-comments').setup({})
require('twilight').setup()
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(opts)
    if opts.data.spec.name == 'cord.nvim' and opts.data.kind == 'update' then
      vim.cmd 'Cord update'
    end
  end
})

require('nvim-highlight-colors').setup({
	virtual_symbol_position = 'inline',
	render = 'background',
	enable_hex = true,
	enable_short_hex = true,
	enable_rgb = true,
	enable_hsl = true,
	enable_ansi = true,
  enable_hsl_without_function = true,
	enable_var_usage = true,
	enable_named_colors = true,
	enable_tailwind = false,
})

require("which-key").setup({
	preset = "helix",
	win = { border = 'single' }
})

-- FFF
-- Autoupdate
vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(event)
		if event.data.updated then
			require('fff.download').download_or_build_binary()
		end
	end,
})

-- The plugin will automatically lazy load
vim.g.fff = {
	lazy_sync = true, -- start syncing only when the picker is open
	debug = {
		enabled = true,
		show_scores = true,
	},
}

require('fff').setup {
	prompt = 'fffind: '
}

-- Colorscheme

vim.cmd("colorscheme rose-pine")

-- Lualine
require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'rose-pine',
		component_separators = { left = '::', right = '::' },
		section_separators = { left = '', right = '' },
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch', 'diff' },
		lualine_c = { 'diagnostics' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
}

-- Treesitter

require "nvim-treesitter.configs".setup({
	ensure_installed = { "lua", "python", "rust", "html", "css", "javascript" , "gdscript" },
	highlight = { enable = true },
	auto_install = true,
	folds = {
		enable = true,
	},
	indent = {
		enable = false,
	},
})

-- LSP

vim.lsp.enable(
	{
		"lua_ls",
		"ty",
		"rust_analyzer",
		"cssls",
		"html",
		"gdscript",
	}
)

vim.lsp.config("lua_ls", {})

vim.diagnostic.config(
	{
		virtual_text = false,
		severity_sort = true,
		virtual_lines = { current_line = true },
	}
)

-- HACK: Autocomplete: Builtin

-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	group = vim.api.nvim_create_augroup('my.lsp', {}),
-- 	callback = function(args)
-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
-- 		if client:supports_method('textDocument/completion') then
-- 			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
-- 			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
-- 			client.server_capabilities.completionProvider.triggerCharacters = chars
-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
-- 			-- vim.lsp.document_color.enable(true, args.buf, { style = 'background' })
-- 		end
-- 	end,
-- })
--
-- vim.cmd [[set completeopt+=menuone,noselect,popup]]

-- Autocomplete: blink.cmp

local group = vim.api.nvim_create_augroup("BlinkCmpLazyLoad", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
	pattern = "*",
	group = group,
	once = true,
	callback = function()
		require("blink.cmp").setup({
			snippets = {
				preset = "default",
			},
			completion = {
				ghost_text = {
					enabled = false, -- Inline completion options
				},
				menu = {
					draw = {
						components = {
							-- customize the drawing of kind icons
							kind_icon = {
								text = function(ctx)
									-- default kind icon
									local icon = ctx.kind_icon
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
										if color_item and color_item.abbr ~= "" then
											icon = color_item.abbr
										end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									-- default highlight group
									local highlight = "BlinkCmpKind" .. ctx.kind
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
										if color_item and color_item.abbr_hl_group then
											highlight = color_item.abbr_hl_group
										end
									end
									return highlight
								end,
							},
						},
					},
				},
			},
			keymap = { preset = "super-tab" }, -- Tab complete like in VSC*de
			cmdline = { enabled = false }
		})
	end,
})
