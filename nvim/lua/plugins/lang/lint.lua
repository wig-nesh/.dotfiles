return {
	"rshkarin/mason-nvim-lint",
	dependencies = { "mason.nvim", "mfussenegger/nvim-lint" },
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

    lint.linters_by_ft = {
      python = {"pylint"},
    }

    require("mason-nvim-lint").setup()
	end,
}
