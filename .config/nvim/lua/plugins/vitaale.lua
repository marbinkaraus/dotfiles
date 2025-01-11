return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/vitaale",
    lazy = false,
    name = "vitaale",
    priority = 1000,
    config = function()
      -- First load and setup the theme
      require('vitaale').setup()
      -- Then set it as the colorscheme
      vim.cmd.colorscheme "vitaale"
    end
  }
} 