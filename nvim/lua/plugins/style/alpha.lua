return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local function configure()
			local theme = require("alpha.themes.theta")
			local themeconfig = theme.config
			local dashboard = require("alpha.themes.dashboard")

			local header = {
				type = "text",
				val = {
					[[                                                                       ]],
					[[                                                                     ]],
					[[       ████ ██████           █████      ██                     ]],
					[[      ███████████             █████                             ]],
					[[      █████████ ███████████████████ ███   ███████████   ]],
					[[     █████████  ███    █████████████ █████ ██████████████   ]],
					[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
					[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
					[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
					[[                                                                       ]],
				},
				opts = {
					position = "center",
					hl = "Type",
					-- wrap = "overflow";
				},
			}

			local buttons = {
				type = "group",
				val = {
					{ type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
					{ type = "padding", val = 1 },
					dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
					dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
					dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
					dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
					dashboard.button("u", "  Update plugins", ":Lazy sync<CR>"),
					dashboard.button("q", "  Quit", ":qa<CR>"),
				},
				position = "center",
			}

      themeconfig.layout[2] = header
			themeconfig.layout[6] = buttons

			return themeconfig
		end

		require("alpha").setup(configure())
	end,
}
