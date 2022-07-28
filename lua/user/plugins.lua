local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim", commit = "00ec5adef58c5ff9a07f11f45903b9dbbaa1b422" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
	use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }) -- Autopairs, integrates with both cmp and treesitter
	use({ "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })
	use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
	use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
	use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" })
	use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
	use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
	use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
	use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
	use({ "lunarvim/darkplus.nvim", commit = "2584cdeefc078351a79073322eb7f14d7fbb1835" })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- snippets
	use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		commit = "518e27589c0463af15463c9d675c65e464efc2fe",
	})

	-- Git
	use({ "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" })

	-- DAP
	use({ "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" })
	use({ "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" })
	use({ "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" })

	use({ "folke/which-key.nvim" })
	-- use({ "folke/tokyonight.nvim" })
	use({
		"ggandor/lightspeed.nvim",
		disable = false,
		config = function()
			require("lightspeed").setup({
				ignore_case = true,
				-- exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },
				-- --- s/x ---
				-- jump_to_unique_chars = { safety_timeout = 400 },
				-- match_only_the_start_of_same_char_seqs = true,
				-- force_beacons_into_match_width = false,
				-- -- Display characters in a custom way in the highlighted matches.
				-- substitute_chars = { ['\r'] = '¬', },
				-- -- Leaving the appropriate list empty effectively disables "smart" mode,
				-- -- and forces auto-jump to be on or off.
				safe_labels = {},
				-- labels = { . . . },
				-- These keys are captured directly by the plugin at runtime.
				jump_to_unique_chars = false,
				special_keys = {
					next_match_group = "<space>",
					prev_match_group = "<tab>",
				},
				repeat_ft_with_target_char = true,
			})
		end,
		event = "BufRead",
	})

	use({
		"kevinhwang91/nvim-bqf",
		disable = false,
		tag = "*",
		event = { "BufRead", "BufNew" },
		config = function()
			require("bqf").setup({
				auto_enable = true,
				preview = {
					win_height = 12,
					win_vheight = 12,
					delay_syntax = 80,
					border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
				},
				func_map = {
					vsplit = "",
					ptogglemode = "z,",
					stoggleup = "",
				},
				filter = {
					fzf = {
						action_for = { ["ctrl-s"] = "split" },
						extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
					},
				},
			})
		end,
	})
	use({
		"windwp/nvim-spectre",
		disable = false,
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	})
	use({
		"andymass/vim-matchup",
		disable = false,
		tag = "*",
		event = "CursorMoved",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	})
	use({
		"sindrets/diffview.nvim",
		disable = false,
		event = "BufRead",
	})
	-- replacde by :Gitsigns toggle_current_line_blame
	-- {
	-- 	"f-person/git-blame.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		vim.cmd("highlight default link gitblame SpecialComment")
	-- 		vim.g.gitblame_enabled = 0
	-- 	end,
	-- },
	use({
		"tpope/vim-fugitive",
		disable = false,
		tag = "*",
		-- cmd = {
		-- 	"G",
		-- 	"Git",
		-- 	"Gdiffsplit",
		-- 	"Gread",
		-- 	"Gwrite",
		-- 	"Ggrep",
		-- 	"GMove",
		-- 	"GDelete",
		-- 	"GBrowse",
		-- 	"GRemove",
		-- 	"GRename",
		-- 	"Glgrep",
		-- 	"Gedit",
		-- },
		-- ft = { "fugitive" },
	})
	use({
		"windwp/nvim-ts-autotag",
		disable = false,
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})
	use({
		"p00f/nvim-ts-rainbow",
		disable = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					-- ...
				},
				-- ...
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
		end,
	})
	-- {
	-- 	"nvim-telescope/telescope-fzy-native.nvim",
	-- 	run = "make",
	-- 	event = "BufRead",
	-- },
	use({
		"nvim-telescope/telescope-project.nvim",
		disable = false,
		event = "BufWinEnter",
		setup = function()
			vim.cmd([[packadd telescope.nvim]])
		end,
	})
	use({
		"folke/lsp-colors.nvim",
		disable = false,
		event = "BufRead",
	})
	use({
		"rmagatti/goto-preview",
		disable = false,
		config = function()
			require("goto-preview").setup({
				width = 120, -- Width of the floating window
				height = 25, -- Height of the floating window
				default_mappings = true, -- Bind default mappings
				debug = false, -- Print debug information
				opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
				post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
				-- You can use "default_mappings = true" setup option
				-- Or explicitly set keybindings
				-- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
				-- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
				-- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
			})
		end,
	})
	use({
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
				options = { "buffers", "curdir", "tabpages", "winsize" },
			})
		end,
	})
	-- {
	-- 	"ahmedkhalf/lsp-rooter.nvim",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		require("lsp-rooter").setup()
	-- 	end,
	-- },
	use({
		"ray-x/lsp_signature.nvim",
		disable = false,
		event = "BufRead",
		config = function()
			require("lsp_signature").setup()
		end,
	})
	use({
		"simrat39/symbols-outline.nvim",
		tag = "*",
		disable = false,
		cmd = "SymbolsOutline",
	})
	use({
		"npxbr/glow.nvim",
		disable = false,
		ft = { "markdown" },
		-- run = "yay -S glow"
	})
	-- use({
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	disable = false,
	-- 	tag = "*",
	-- 	event = "BufRead",
	-- 	config = function()
	-- 		vim.g.indentLine_enabled = 1
	-- 		vim.g.indent_blankline_char = "▏"
	-- 		vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
	-- 		vim.g.indent_blankline_buftype_exclude = { "terminal" }
	-- 		vim.g.indent_blankline_show_trailing_blankline_indent = false
	-- 		vim.g.indent_blankline_show_first_indent_level = false
	-- 		vim.g.indent_blankline_show_current_context = true
	-- 		vim.g.indent_blankline_show_current_context_start = true
	-- 	end,
	-- })
	use({
		"iamcco/markdown-preview.nvim",
		disable = false,
		run = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
		end,
	})
	use({
		"ethanholz/nvim-lastplace",
		disable = false,
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	})
	use({
		"folke/todo-comments.nvim",
		disable = false,
		event = "BufRead",
		config = function()
			require("todo-comments").setup()
		end,
	})
	-- {
	--   "tpope/vim-surround",
	--   keys = {"c", "d", "y"},
	-- config = function ()
	--         vim.cmd("nmap ds       <Plug>Dsurround")
	--         vim.cmd("nmap cs       <Plug>Csurround")
	--         vim.cmd("nmap cS       <Plug>CSurround")
	--         vim.cmd("nmap ys       <Plug>Ysurround")
	--         vim.cmd("nmap yS       <Plug>YSurround")
	--         vim.cmd("nmap yss      <Plug>Yssurround")
	--         vim.cmd("nmap ySs      <Plug>YSsurround")
	--         vim.cmd("nmap ySS      <Plug>YSsurround")
	--         vim.cmd("xmap gs       <Plug>VSurround")
	--         vim.cmd("xmap gS       <Plug>VgSurround")
	--       end
	-- },
	-- { "oberblastmeister/neuron.nvim" },
	-- fred plugin perso
	-- {
	--     "blackCauldron7/surround.nvim",
	--     config = function()
	--        require("surround").setup { mappings_style = "sandwich", prefix = "e" }
	--     end,
	--  },
	use({ "stevearc/aerial.nvim", disable = false })
	use({
		"voldikss/vim-translator",
		disable = false,
		config = function()
			vim.api.nvim_set_var("translator_target_lang", "fr")
			vim.api.nvim_set_var("translator_source_lang", "en")
			vim.api.nvim_set_var("translator_proxy_url", "http://proxy.onera:80")
		end,
	})
	-- {
	--       "Shatur/neovim-cmake",
	--       config = function()
	-- require('cmake').setup({
	----parameters_file = 'neovim.json',
	--JSON file to store information about selected target,
	-- run arguments and build type.--build_dir = '{cwd}/build',
	-- --Build directory.The expressions `{
	--   cwd
	-- }
	-- `, `{ os }
	-- ` and `{ build_type }` will be expanded with the corresponding text values.
	--   -- samples_path = script_path:parent():parent():parent() / 'samples', -- Folder with samples. `samples` folder from the plugin directory is used by default.
	--   -- default_projects_path = '~/Projects', -- Default folder for creating project.
	--   -- configure_arguments = '-D CMAKE_EXPORT_COMPILE_COMMANDS=1', -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
	--   -- build_arguments = '', -- Default arguments that will be always passed at cmake build step.
	--   -- asyncrun_options = { save = 2 }, -- AsyncRun options that will be passed on cmake execution. See https://github.com/skywind3000/asyncrun.vim#manual
	--   -- target_asyncrun_options = {}, -- AsyncRun options that will be passed on target execution. See https://github.com/skywind3000/asyncrun.vim#manual
	--   -- dap_configuration = { type = 'cpp', request = 'launch' }, -- DAP configuration. By default configured to work with `lldb-vscode`.
	--   -- dap_open_command = require('dap').repl.open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
	-- })
	--       end,
	--    },

	use({ "skywind3000/asyncrun.vim", disable = false })

	use({ "skywind3000/asynctasks.vim", disable = false })

	use({ "simnalamburt/vim-mundo", disable = false })
	use({ "vim-scripts/DoxygenToolkit.vim", disable = false })
	use({
		"kosayoda/nvim-lightbulb",
		disable = false,
		config = function()
			vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
		end,
	})
	use({
		"hrsh7th/cmp-cmdline",
		disable = false,
	})
	use({
		"hrsh7th/cmp-calc",
		disable = false,
		after = "cmp-nvim-lsp",
	})
	use({
		"uga-rosa/cmp-dictionary",
		disable = false,
	})
	use({
		"f3fora/cmp-spell",
		disable = false,
	})
	use({
		"nacro90/numb.nvim",
		disable = false,
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
				number_only = false, -- Peek only when the command is only a number instead of when it starts with a number
			})
		end,
	})
	use({
		"rhysd/git-messenger.vim",
		disable = false,
		config = function()
			-- vim.api.nvim_command 'let g:git_messenger_include_diff="current"'
			vim.api.nvim_command("let g:git_messenger_floating_win_opts = { 'border': 'single' }")
			vim.api.nvim_command("let g:git_messenger_no_default_mappings=v:true")
			vim.api.nvim_command("let g:git_messenger_always_into_popup=v:true")
		end,
	})
	use({ "mg979/vim-visual-multi", disable = false, config = function() end })
	use({ "xolox/vim-misc", disable = false })
	use({ "xolox/vim-colorscheme-switcher", disable = false })
	use({
		"rhysd/devdocs.vim",
		disable = false,
		config = function()
			vim.cmd([[let g:devdocs_filetype_map = {
    \   'c': 'cpp'}
    ]])
		end,
	})
	use({
		"nvim-neorg/neorg",
		disable = false,
		config = function()
			require("neorg").setup({
				-- Tell Neorg what modules to load
				load = {
					["core.defaults"] = {}, -- Load all the default modules
					["core.integrations.telescope"] = {},
					["core.keybinds"] = { -- Configure core.keybinds
						config = {
							default_keybinds = true, -- Generate the default keybinds
							neorg_leader = "<Leader>ze", -- This is the default if unspecified
						},
					},
					["core.norg.concealer"] = {}, -- Allows for use of icons
					["core.norg.dirman"] = { -- Manage your directories with Neorg
						config = {
							workspaces = {
								work = "~/NEORG/work",
								home = "~/NEORG/home",
							},
						},
					},
					["core.norg.completion"] = {
						config = {
							engine = "nvim-cmp", -- We current support nvim-compe and nvim-cmp only
						},
					},
				},
			})
		end,
		requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
	})
	use({ "nvim-neorg/neorg-telescope", disable = false })
	use({
		"mzlogin/vim-markdown-toc",
		disable = false,
	})
	use({ "nvim-telescope/telescope-live-grep-args.nvim", disable = false })
	use({ "kazhala/close-buffers.nvim", disable = false })
	use({
		"chipsenkbeil/distant.nvim",
		disable = false,
		config = function()
			require("distant").setup({
				-- Applies Chip's personal settings to every machine you connect to
				--
				-- 1. Ensures that distant servers terminate with no connections
				-- 2. Provides navigation bindings for remote directories
				-- 3. Provides keybinding to jump into a remote file's parent directory
				["*"] = require("distant.settings").chip_default(),
			})
		end,
	})
	use({ "ckipp01/nvim-jenkinsfile-linter", disable = false, requires = { "nvim-lua/plenary.nvim" } })
	use({ "kdheepak/lazygit.nvim", disable = false })
	use({ "rafi/awesome-vim-colorschemes", disable = false })
	use({
		"Shatur/neovim-cmake",
		disable = false,
		config = function()
			local Path = require("plenary.path")
			require("cmake").setup({
				cmake_executable = "cmake", -- CMake executable to run.
				parameters_file = "neovim.json", -- JSON file to store information about selected target, run arguments and build type.
				-- build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values.
				build_dir = tostring(Path:new("{cwd}", "build")), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values.
				-- samples_path = tostring(script_path:parent():parent():parent() / 'samples'), -- Folder with samples. `samples` folder from the plugin directory is used by default.
				default_projects_path = tostring(Path:new(vim.loop.os_homedir(), "Projects")), -- Default folder for creating project.
				configure_args = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
				build_args = {}, -- Default arguments that will be always passed at cmake build step.
				on_build_output = nil, -- Callback which will be called on every line that is printed during build process. Accepts printed line as argument.
				quickfix_height = 10, -- Height of the opened quickfix.
				-- quickfix_only_on_error = true, -- Open quickfix window only if target build failed.
				dap_configuration = { type = "cpp", request = "launch" }, -- DAP configuration. By default configured to work with `lldb-vscode`.
				dap_open_command = require("dap").repl.open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
			})
		end,
	})
	use({ "Pocco81/TrueZen.nvim", disable = false })
	-- not work with lvim
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})
	use({
		"phaazon/hop.nvim",
		event = "BufRead",
		tag = "*",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "e", "<cmd>HopChar1<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "E", "<cmd>HopWord<cr>", { silent = true })
			vim.api.nvim_set_keymap("v", "e", "<cmd>HopChar1<cr>", { silent = true })
			vim.api.nvim_set_keymap("v", "E", "<cmd>HopWord<cr>", { silent = true })
		end,
	})
	use({ "kg8m/vim-simple-align" })
	use({
		"romgrk/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				throttle = true, -- Throttles plugin updates (may improve performance)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"class",
						"function",
						"method",
						"for",
						"while",
						"if",
						"switch",
						"case",
					},
				},
			})
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			require("nvim-treesitter.configs").setup({
				textobjects = {
					-- swap = {
					-- 	enable = true,
					-- 	swap_next = {
					-- 		["<leader>a"] = "@parameter.inner",
					-- 	},
					-- 	swap_previous = {
					-- 		["<leader>A"] = "@parameter.inner",
					-- 	},
					-- },
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["<leader>aj"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["<leader>ak"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
				},
			})
		end,
	})
	use({
		"tpope/vim-repeat", -- permet de répeter la dernière commande avec .
	})
	use({
		"gelguy/wilder.nvim",
		config = function()
			-- require("wilder").setup({
			-- 	{ modes = { ":", "/", "?" } },
			-- })
		end,
	})
	-- use({
	-- 	"windwp/windline.nvim",
	-- 	config = function()
	-- 		require("wlsample.evil_line")
	-- 		require("wlfloatline").setup()
	-- 	end,
	-- })
	use({
		"vim-test/vim-test",
	})
  use({"brymer-meneses/grammar-guard.nvim"})
  use({"p00f/clangd_extensions.nvim"})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
