vim.api.nvim_create_autocmd({"BufWritePost", "BufReadPost"}, {
  callback = function() 
    require("nabla").enable_virt() 
  end
})
