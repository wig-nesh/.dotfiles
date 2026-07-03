return {
  "kdheepak/lazygit.nvim",
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "lewis6991/gitsigns.nvim"
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "lazyGit" },
  },
  lazy = true,
  event = {"BufReadPre", "BufNewFile"},
  config = function ()
    require("gitsigns").setup()
  end
}
