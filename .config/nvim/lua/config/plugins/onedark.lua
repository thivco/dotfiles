return {
  {
    "navarasu/onedark.nvim",
    priority = 3000, -- make sure to load this before all the other start plugins
    lazy = false,
    config = function()
      require('onedark').setup {
        style = 'darker'
      }
      require('onedark').load()
    end
  }
}
