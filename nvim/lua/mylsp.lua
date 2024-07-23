-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
-- vim.api.nvim_set_keymap('n', 'gE', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
-- vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'i', ',s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ',wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>qf', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua require("trouble").open("lsp_references") <CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>uh', 
        '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>'
  , opts)


  vim.keymap.set('n', 'K', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
          vim.lsp.buf.hover()
      end
  end, {buffer = bufnr})

  -- vim.api.nvim_create_autocmd({"BufWritePre"}, {
  --     callback = function() vim.lsp.buf.format({async = false}) end,
  --     buffer = bufnr
  -- })
end
local configs = require'lspconfig.configs'
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'clangd', 'zls', 'pyright', 'rust_analyzer', 'r_language_server', 'hls'}
-- for _, lsp in pairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
-- end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}


require('lspconfig').clangd.setup {
  cmd = {"clangd"},
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set("n", "gs", '<cmd>ClangdSwitchSourceHeader<cr>', { buffer = bufnr, silent = true })
  end,
  capabilities = capabilities
}
require('lspconfig').nil_ls.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
    settings = {
     ['nil'] = {
       testSetting = 42,
       formatting = {
         command = { "nixpkgs-fmt" },
       },
     },
     }
}

require('lspconfig').hls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require('lspconfig').r_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
      ["r.lsp.diagnostics"] = false,
  }
}

require('lspconfig').svelte.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
require('lspconfig').wgsl_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require('lspconfig').uiua.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require('lspconfig').texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require('lspconfig').zls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

require('lspconfig').pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- require('lspconfig').sumneko_lua.setup {
--     on_attach = on_attach,
--     capabilities = capabilities
-- }

local rt = require('rust-tools')
rt.setup({
    server = {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            vim.keymap.set('n', 'K', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                  rt.hover_actions.hover_actions()
                end
            end, {buffer = bufnr})
            vim.keymap.set("n", "<leader>qf", rt.code_action_group.code_action_group, {buffer = bufnr})
        end,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true
                },
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    }
})

require('lspconfig').emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'xslt'},
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})
