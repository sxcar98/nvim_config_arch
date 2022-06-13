local vim = vim

local lspconfig = require "lspconfig"

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- specific language server settings

local configs = {
  texlab = {
    settings = {
      rootDirectory = nil,
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-xelatex" },
        onSave = false,
        forwardSearchAfter = true
      },
      auxDirectory = ".",
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = {
          "-r",
          "%l",
          "%p",
          "%f"
        }
      },
      chktex = {
        onOpenAndSave = false,
        onEdit = false
      },
      diagnosticsDelay = 300,
      latexFormatter = "latexindent",
      latexindent = {
        ["local"] = nil, -- local is a reserved keyword
        modifyLineBreaks = false
      },
      bibtexFormatter = "texlab",
      formatterLineLength = 80
    },
  },
  clangd = {
    settings = {

    },
  },
}

-- lspservers with default config
local servers = {
  "clangd",
  "sumneko_lua",
}

for _, lsp in ipairs(servers) do
  local conf = configs[lsp]
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150
    },
    settings = conf
  }
end
