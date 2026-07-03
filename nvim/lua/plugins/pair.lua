return {
	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					visual = "vs",
					visual_line = "vS",
				},
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"mbbill/undotree",
		lazy = true,
		event = "VeryLazy",
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		event = "BufEnter",
		config = function()
			vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			})
			vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search on current file",
			})
		end,
	},
}
