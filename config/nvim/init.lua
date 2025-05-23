require("user.remap")
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip'},
  },
  -- {
  --   'ray-x/lsp_signature.nvim',
  -- },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  { -- Catppuccin theme
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },

  -- {
  --   'stevearc/aerial.nvim',
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons"
  --   },
  -- },
  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  -- { -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   main = "ibl",
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   opts = {
  --     -- char = '┊',
  --     -- show_trailing_blankline_indent = false,
  --   },
  -- },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
  -- {
  --   'stevearc/oil.nvim',
  --   opts = {},
  --   -- Optional dependencies
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  -- },
  { -- Marks plugin for better mark usage
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  { 'JuliaEditorSupport/julia-vim' },
  {
    'RaafatTurki/hex.nvim',
    config = function()
      require 'hex'.setup()
    end,
  },
  { 'maxbane/vim-asm_ca65', },
  {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require("nvim-navic").setup({
        lsp = {
          auto_attach = true,
          preference = nil,
        },
      })
    end,
  },
  {
    'simrat39/symbols-outline.nvim'
  },
  {
    'folke/trouble.nvim',
    opts = {},
    modes = {
      test = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader><tab>",
        "<cmd>Trouble symbols toggle focus=false<cr>",
      },
      {
        "<leader>t",
        "<cmd>Trouble diagnostics toggle focus=true<cr>",
      },
    }
  },

  -- {
  --   "epwalsh/obsidian.nvim",
  --   lazy = true,
  --   event = { "BufReadPre /home/gerb/uni/Vault-MSc/**.md" },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",-- Required.
  --     -- Optional, alternative to nvim-treesitter for syntax highlighting.
  --     "godlygeek/tabular",
  --     "preservim/vim-markdown",
  --   },
  --   opts = {
  --     dir = "~/uni/Vault-MSc/",  -- no need to call 'vim.fn.expand' here
  --   },
  --   config = function(_, opts)
  --     require("obsidian").setup(opts)
  --
  --     -- Optional, override the 'gf' keymap to utilize Obsidian's search functionality.
  --     -- see also: 'follow_url_func' config option below.
  --     vim.keymap.set("n", "gf", function()
  --       if require("obsidian").util.cursor_on_markdown_link() then
  --         return "<cmd>ObsidianFollowLink<CR>"
  --       else
  --         return "gf"
  --       end
  --     end, { noremap = false, expr = true })
  --   end,
  -- },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },

  'mbbill/undotree',
  'mechatroner/rainbow_csv',
  -- 'lervag/vimtex',

  -- REPL driven workflow from vim
  'jpalardy/vim-slime',

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "folke/zen-mode.nvim",
  },
  -- -- Setting up nvim debug adapter protocol
  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     "mfussenegger/nvim-dap-python",
  --     "rcarriga/nvim-dap-ui",
  --     "theHamsta/nvim-dap-virtual-text",
  --     "nvim-neotest/nvim-nio",
  --   },
  --    config = function()
  --     local dap = require "dap"
  --     local ui = require "dapui"
  --
  --     require("dapui").setup()
  --     require("dap-python").setup("python3")
  --
  --
  --     require("nvim-dap-virtual-text").setup {
  --       -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
  --       display_callback = function(variable)
  --         local name = string.lower(variable.name)
  --         local value = string.lower(variable.value)
  --         if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
  --           return "*****"
  --         end
  --
  --         if #variable.value > 15 then
  --           return " " .. string.sub(variable.value, 1, 15) .. "... "
  --         end
  --
  --         return " " .. variable.value
  --       end,
  --     }
  --
  --     vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
  --     vim.keymap.set("n", "<space>gb", dap.run_to_cursor)
  --
  --     -- Eval var under cursor
  --     vim.keymap.set("n", "<space>?", function()
  --       require("dapui").eval(nil, { enter = true })
  --     end)
  --
  --     vim.keymap.set("n", "<F1>", dap.continue)
  --     vim.keymap.set("n", "<F2>", dap.step_into)
  --     vim.keymap.set("n", "<F3>", dap.step_over)
  --     vim.keymap.set("n", "<F4>", dap.step_out)
  --     vim.keymap.set("n", "<F5>", dap.step_back)
  --     vim.keymap.set("n", "<F13>", dap.restart)
  --
  --     dap.listeners.before.attach.dapui_config = function()
  --       ui.open()
  --     end
  --     dap.listeners.before.launch.dapui_config = function()
  --       ui.open()
  --     end
  --     dap.listeners.before.event_terminated.dapui_config = function()
  --       ui.close()
  --     end
  --     dap.listeners.before.event_exited.dapui_config = function()
  --       ui.close()
  --     end
  --   end,
  -- },
},
{})
-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers relative
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('i', '<C-c>', "<ESC>")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').lsp_workspace_symbols, { desc = '[S]earch [W]orkspace symbols' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim' },
  ignore_install = { 'help'},

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>rf', vim.lsp.buf.format, '[R]e[F]ormat')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  matlab_ls = {
    cmd = { "~/.local/share/nvim/mason/bin/matlab-language-server", "--stdio" },
    filetype = { "matlab" },
    matlab = {
      indexWorkspace = false,
      installPath = "/usr/local/MATLAB/R2023a/",
      matlabConnectionTiming = 'onStart',
      telemetry = false,
    },
  }
}

require("lspconfig").matlab_ls.setup({
  cmd = { "~/.local/share/nvim/mason/bin/matlab-language-server", "--stdio" },
  filetype = { "matlab" },
  matlab = {
    indexWorkspace = false,
    installPath = "/usr/local/MATLAB/R2023a/",
    matlabConnectionTiming = 'onStart',
    telemetry = false,
  },
})

require("lspconfig").julials.setup({
  on_new_config = function(new_config, _)
    local julia = vim.fn.expand("~/.julia/environments/nvim-lspconfig/bin/julia")
    if require("lspconfig").util.path.is_file(julia) then
      new_config.cmd[1] = julia
    end
  end,
})

require('lspconfig').pyright.setup{
    on_init = function(client)
        client.config.settings.python = {
            analysis = {
                diagnosticSeverityOverrides = {
                    reportUnusedVariable = "none",
                },
            },
        }
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        return true
    end,
}
vim.cmd [[highlight! link LspDiagnosticsVirtualTextHint Normal]]


-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {
  enable_autosnippets = true,
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-j>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<C-k>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/luasnip/"})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
vim.opt.guicursor = ""
vim.opt.scrolloff = 8
vim.o.wrap = false
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.sw = 4
vim.o.ts = 4
vim.o.expandtab = true
vim.opt.expandtab = true
vim.o.conceallevel = 0

-- Markdown config
vim.g.vim_markdown_folding_disabled = 1
vim.g.tex_conceal = ""
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_frontmatter = 1


-- require('aerial').setup({
--   on_attach = function(bufnr)
-- -- optionally use on_attach to set keymaps when aerial has attached to a buffer
--     -- Jump forwards/backwards with '{' and '}'
--     vim.keymap.set('n', '<leader>[', '<cmd>AerialNavToggle<CR>', {buffer = bufnr})
--   end
-- })
-- vim.keymap.set('n', '<leader><tab>', '<cmd>AerialToggle<cr>')


-- Configuring slime
vim.g.slime_target = "tmux"
vim.keymap.set("n", "<c-c><c-x>", "<cmd>%SlimeSend<cr>")
vim.keymap.set("n", "<c-c><c-f>", "<cmd>!tmux send-keys -t 2 %:r C-m<cr>")

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<cr>')
-- vim.keymap.set('n', '<leader><tab>', '<cmd>NeoTreeFocusToggle<cr>')

local navic = require("nvim-navic")
require("lualine").setup({
    sections = {
        lualine_c = {
            {
              function()
                  return navic.get_location()
              end,
              cond = function()
                  return navic.is_available()
              end
            },
        }
    },
})

-- require'lsp_signature'.setup({
--   debug = false, -- set to true to enable debug logging
--   log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
--   -- default is  ~/.cache/nvim/lsp_signature.log
--   verbose = false,
--   bind = true, -- This is mandatory, otherwise border config won't get registered.
--   doc_lines = 0, -- set to 0 if you DO NOT want any API comments be shown
--   max_height = 12, -- max height of signature floating_window
--   max_width = 80, -- max_width of signature floating_window, line will be wrapped if exceed max_width
--   -- the value need >= 40
--   wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
--   floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
--
--   floating_window_above_cur_line = true, 
--
--   floating_window_off_x = 1, -- adjust float windows x position.
--                              -- can be either a number or function
--   floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
--                               -- can be either number or function, see examples
--   hint_enable = false, -- virtual hint enable
--   hint_prefix = "󰏚 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
--   hint_scheme = "String",
--   hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
--   handler_opts = {
--     border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
--   },
--
--   always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
--   auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
--   extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
--   transparency = nil, -- disabled by default, allow floating win transparent value 1~100
--   toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
-- })
