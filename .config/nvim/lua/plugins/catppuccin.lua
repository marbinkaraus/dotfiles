return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
      -- make the background transparent
      vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
    end
  }
}
