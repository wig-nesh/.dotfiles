return {
	{
		"ErickKramer/nvim-ros2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		event = "VeryLazy",
		opts = {
			-- Add any custom options here
			autocmds = true,
			telescope = true,
			treesitter = true,
		},
	},
	{
		"thibthib18/ros-nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		event = "VeryLazy",
		opts = {},
	},
}
