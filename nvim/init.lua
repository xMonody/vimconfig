local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local po={noremap = true, silent = true }

local plugins = {
    { "folke/lazy.nvim" },
    { "williamboman/mason.nvim" },

    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "saecki/crates.nvim", version = "v0.3.0", dependencies = { "nvim-lua/plenary.nvim" } },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    --[[ { "ray-x/lsp_signature.nvim" }, ]]
    { "rmagatti/goto-preview" },

    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },

    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },

    { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies =
    { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", } },

    { "akinsho/toggleterm.nvim" }, --终端

    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, --模糊搜索
    { "lewis6991/gitsigns.nvim" }, --git修改 
    { "stevearc/aerial.nvim" }, --大纲

    { "brenoprata10/nvim-highlight-colors" },
    { "catppuccin/nvim", name = "catppuccin" },
    { "mhartington/formatter.nvim" },--格式化

    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },

    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

    { "lukas-reineke/indent-blankline.nvim" }, --对齐线
    --[[ { "RRethy/vim-illuminate" },--突出光标下单词 ]]

    { "numToStr/Comment.nvim" }, --注释
    { "windwp/nvim-autopairs" }, --括号补全
    { "Pocco81/auto-save.nvim" }, --自动保存

    --[[ { 'nvimdev/dashboard-nvim', config = function() require('dashboard').setup { } end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}} }, ]]
}

require("lazy").setup(plugins,{
    install = { missing = true, colorscheme = { "catppuccin" }, },
    ui = {
    backdrop = 100,
    size = { width = 0.8, height = 0.7 },
        icons = { loaded = "󰄳 ", not_loaded = " ", list = { "󰠠 ", " ", " ", " ", }, },
        wrap = false,
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
    },
})

local win32yank_available = vim.fn.executable('win32yank') == 1
if win32yank_available then -- 统一 win32yank 配置
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank -i --crlf',
      ['*'] = 'win32yank -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank -o --lf',
      ['*'] = 'win32yank -o --lf',
    },
    cache_enabled = true,
  }
else -- Linux 环境检测
  local is_wayland = vim.env.WAYLAND_DISPLAY ~= nil
    or vim.env.XDG_SESSION_TYPE == 'wayland'
  local is_x11 = vim.env.DISPLAY ~= nil
    and (vim.env.XDG_SESSION_TYPE == nil or vim.env.XDG_SESSION_TYPE ~= 'wayland')

  if is_wayland and vim.fn.executable('wl-copy') == 1 then --Wayland优先 即使同时安装了xclip
    vim.g.clipboard = {
      name = 'wl-clipboard',
      copy = {
        ['+'] = 'wl-copy',
        ['*'] = 'wl-copy',
      },
      paste = {
        ['+'] = 'wl-paste',
        ['*'] = 'wl-paste',
      },
      cache_enabled = true,
    }
  elseif is_x11 and vim.fn.executable('xclip') == 1 then -- X11环境
    vim.g.clipboard = {
      name = 'xclip',
      copy = {
        ['+'] = 'xclip -selection clipboard',
        ['*'] = 'xclip -selection primary',
      },
      paste = {
        ['+'] = 'xclip -selection clipboard -o',
        ['*'] = 'xclip -selection primary -o',
      },
      cache_enabled = true,
    }
  end
end

vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true --设置tab=空格
vim.o.scrolloff = 6
vim.o.pumheight = 7
vim.wo.numberwidth = 1
vim.o.laststatus=2
vim.transparent_window = true
vim.g.mapleader = ","
vim.g.maplocalleader = ","
vim.wo.cursorline = true
vim.o.autoindent = true
vim.o.shiftround = true
vim.o.hlsearch = true
vim.wo.number = true
vim.o.mouse = "a"
vim.o.swapfile = false
vim.o.breakindent = true
vim.opt.undofile = true
vim.o.ignorecase = true --搜索忽略大小写
vim.o.smartcase = true
vim.o.updatetime = 200
vim.wo.signcolumn = "yes"
vim.o.cmdheight = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.o.backspace = "indent,eol,start" --设置back键
vim.opt.completeopt = "menu,menuone,noinsert"

if vim.g.guicursor ~= "" then
    vim.o.guifont = "SauceCodePro NFM:h15"
end
if vim.g.neovide then
    vim.g.neovide_floating_shadow = false
    vim.g.neovide_hide_mouse_when_typing = true --隐藏鼠标
    vim.g.neovide_theme = 'auto'
    --[[ vim.g.neovide_refresh_rate = 60 ]]
    vim.g.neovide_remember_window_size = true --记住上次窗口大小

    vim.g.neovide_cursor_smooth_blink = false
    vim.g.neovide_cursor_trail_size = 0.1
    vim.g.neovide_cursor_animation_length = 0.1 --光标动画时间
    vim.g.neovide_position_animation_length = 0.1 --跳转时间
    vim.g.neovide_scroll_animation_length = 0.1 --滚动时间

    vim.g.neovide_cursor_vfx_mode = "pixiedust" --ripple
    vim.g.neovide_cursor_vfx_particle_density = 1
    vim.g.neovide_cursor_vfx_opacity = 300
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove("r")
        vim.opt_local.formatoptions:remove("o")
    end,
})

--[[ vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.frag", "*.vert", "*.vs", "*.fs"},
    callback = function()
        vim.bo.filetype = "glsl"
    end
}) ]]

vim.opt.viewoptions:append("cursor")
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    command = "silent! normal! g`\""
})
--[[ vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        vim.schedule(function()
            vim.cmd("redraw")
        end)
    end
}) ]]

local function redraw_safe()
    vim.schedule(vim.cmd.redraw)
end
vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = redraw_safe,
    desc = "Ensure UI redraw after mode change"
})

---------------------------------------------------------------------------------------------------
require("mason").setup({
    ui = {
        check_outdated_packages_on_open = true,
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
        backdrop = 100,
        width = 0.8,
        height = 0.7,
        icons = {
            package_installed   = "◍",
            package_pending     = "◍",
            package_uninstalled = "◍",
        },
    }
})

---------------------------------------------------------------------------------------------------
--vim.o.winborder='rounded'
--vim.keymap.set('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>')
vim.keymap.set('n', 'gp', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.diagnostic.goto_next()<cr>')
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
        vim.keymap.set('n', 'gh', function() vim.lsp.buf.signature_help({ border = "rounded"}) end, opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

        --[[ vim.keymap.set('n', 'gc', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts) ]]
    end,
})
vim.api.nvim_create_augroup("CustomHighlights", { clear = true })

--[[ vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        vim.keymap.set({ "n", "x" }, "<Leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Actions" })
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
    end,
}) ]]

vim.api.nvim_create_autocmd("ColorScheme", {
    group = "CustomHighlights",
    pattern = "*",
    callback = function()
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = "NONE", bold = false })
        vim.api.nvim_set_hl(0, "PmenuSel", {    bg = "#51576d", bold = false })
        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#686eaa", bg = "NONE" })

        vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#D55F6F", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticSignWarn",  { fg = "#ea9a71", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticSignInfo",  { fg = "#87beaa", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticSignHint",  { fg = "#CA9EE6", bg = "NONE" })

        --[[ vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#D55F6F", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = "#ea9a71", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = "#87beaa", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = "#CA9EE6", bg = "NONE" }) ]]


        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError",   { fg = "#D55F6F", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",    { fg = "#ea9a71", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",    { fg = "#87beaa", bg = "NONE" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",    { fg = "#CA9EE6", bg = "NONE" })
    end
})
vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "*", group = "CustomHighlights" })

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '󰠠',
        },
    },
    float = {
        show_header = true,
        border = "rounded",
        focusable = false,
    },
    virtual_text = false,
    --[[ virtual_text = { prefix = "", }, ]]
    underline = true,
    update_in_insert = false,
    severity_sort = false,

})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
    snippetSupport = true,
    documentationFormat = { "markdown", "plaintext" },
}

--[[ local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem = {
    snippetSupport = true,
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
            "labelDetails",
            "signatureHelp"
        }
    }
} ]]

local on_attach = function(client,bufnr) --开启inlay_hint
    --[[ vim.lsp.completion.enable(false, client.id, bufnr) ]]
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

--[[ local on_init = function(client, _) --关闭高亮
    if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end ]]

vim.lsp.enable({ 'clangd','rust_analyzer','glsl_analyzer','lua_ls','cmake' })

vim.lsp.config('clangd', {
    reuse_client = function(_,_)
        return true
    end,
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
    cmd = { 'clangd', "--background-index", "--header-insertion=never",
    "--header-insertion-decorators=false", "--log=verbose" },
    capabilities = capabilities,
    --on_attach=on_attach
    --[[ on_init=on_init, ]]
})

vim.lsp.config('cmake-language-server', {
    filetypes = { "cmake" },
    cmd={ "cmake-language-server" },
    capabilities = capabilities,
    --on_attach = on_attach
    --[[ on_init = on_init, ]]
})

vim.lsp.config('glsl_analyzer', {
    filetypes = { 'glsl', 'vert', 'tesc', 'tese', 'frag', 'geom', 'comp', 'vs', 'fs' },
    cmd = { 'glsl_analyzer' },
    capabilities = capabilities,
    --on_attach = on_attach
    --[[ on_init = on_init, ]]
})

vim.lsp.config('rust_analyzer', {
    filetypes = { "rust" },
    cmd = { "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            inlayHints = {
                parameterHints = { enable = true, },
                typeHints = { enable = false, },
                chainingHints = { enable = true, },
                closingBraceHints = { enable = true, },
                procMacro = { enable = true, },
                closureStyleHints = { enable = true },
                lifetimeElisionHints = { enable = false },

                reborrowHints = { enable = false },
                bindingModeHints = { enable = false },
                closureCaptureHints = { enable = false },
                discriminantHints = { enable = false },
                expressionAdjustmentHints = {
                    enable = "never",
                    --[[ enable =true, ]]
                },
            },
        },
    },
    --[[ on_init=on_init, ]]
    capabilities = capabilities,
    on_attach = on_attach
})

--[[ vim.lsp.enable("gopls")
vim.lsp.config('gopls', {
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    cmd = { "gopls" },
    init_options = { usePlaceholders = false,
        completeUnimported = true, },
    settings = {
        gopls = {
            semanticTokens = true ,
            hints = {
                assignVariableTypes = true,
                rangeVariableTypes = true,
                parameterNames = true,
                functionTypeParameters = true,
            },
        },
    },
    --on_init = on_init
    capabilities = capabilities,
    on_attach = on_attach,
}) ]]

--[[ vim.lsp.enable("ts_ls")
vim.lsp.config('ts_ls',{
    cmd = {'typescript-language-server', '--stdio'},
    settings = {
        javascript = {
            inlayHints = {
                includeInlayParameterNameHints = 'all', --显示参数名称提示 'literals' 'none' 'all'
                includeInlayParameterNameHintsWhenArgumentMatchesName=false, --当参数名与变量名相同时是否显示
                includeInlayFunctionParameterTypeHints = true,  --显示函数参数类型提示
                includeInlayVariableTypeHints = false, -- 显示变量类型提示
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,  --当类型名与变量名相同时是否显示
                includeInlayPropertyDeclarationTypeHints = true,  --显示属性声明类型提示
                includeInlayFunctionLikeReturnTypeHints = false,  --显示函数返回类型提示
                includeInlayEnumMemberValueHints = true,  --显示枚举成员值提示
            },
        },
    },
    --on_init = on_init
    capabilities = capabilities,
    on_attach = on_attach,
}) ]]

vim.lsp.config('lua_ls', {
    filetypes = { "lua" },
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            hint = {
                enable = true,
                paramName = 'Literal',
                setType = true,
            },
            workspace = {
                library = {
                    vim.fn.expand "$VIMRUNTIME/lua",
                    vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/luv/library",
                },
            },
        },
    },
    capabilities = capabilities,
    --on_attach = on_attach
    --[[ on_init = on_init, ]]
})

---------------------------------------------------------------------------------------------------
-- luasnip setup
local kind_icons = {
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Enum = "",
    EnumMember = "",
    Event = "󱐋",
    Field = "󰇽",
    File = "",
    Folder = "",
    Function = "󰊕",
    Interface = "",
    Keyword = "",
    Method = "",
    Module = "",
    Operator = "󰆕",
    Property = "󰜢",
    Reference = "",
    Snippet = "󰉿",
    Struct = "",
    Text = "󱀍",
    TypeParameter = "󰅲",
    Unit = "",
    Value = "",
    Variable = "",
}

local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 40

local luasnip = require("luasnip")
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    require("luasnip.loaders.from_vscode").lazy_load({paths={"D:/vimconfig/mysnip"}})
else
    require("luasnip.loaders.from_vscode").lazy_load({paths={"~/vimconfig/mysnip"}})
end

--cmpconfig
local cmp = require("cmp")
cmp.setup({
    preselect = 'item',
    completion = { completeopt = 'menu,menuone,noinsert' },

    view = { entries = { name = 'custom' } },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    window = {
        documentation=cmp.config.disable,
        completion = {
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            completeopt = "menu,menuone,noinsert",
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            max_height = 10,
            col_offset=0,
            side_padding=1,
            scrollbar=false
        },
    },
    --[[ experimental = {
        ghost_text = true,
    }, ]]

    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-j>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-u>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.abort()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.abort()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    },

    sources = {
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "crates" },
        { name = 'nvim_lsp_signature_help' }
    },

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)

            local label = vim_item.abbr
            local truncated_label = vim.fn.strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
                vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            end
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp  = "Lsp",
                luasnip   = "Snp",
                buffer    = "Buf",
                paht      = "Pat",
                nvim_lua  = "Lua",
            })[entry.source.name]
            return vim_item
        end,
    },
})

require('crates').setup {
}

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-------------------------------------------------------------------------------------------------
--gotoconfig
require('goto-preview').setup {
    width = 120; -- Width of the floating window
    height = 15; -- Height of the floating window
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    default_mappings = false; -- Bind default mappings
    debug = false; -- Print debug information
    opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
    resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
    post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
    post_close_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
    references = { telescope = require("telescope.themes").get_dropdown({ hide_preview = false }) };
    focus_on_open = true; -- Focus the floating window when opening it.
    dismiss_on_move = false; -- Dismiss the floating window when moving the cursor.
    force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
    bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
    stack_floating_preview_windows = true, -- Whether to nest floating windows
    preview_window_title = { enable = true, position = "left" },
}
vim.api.nvim_set_keymap("n","<C-g>","<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
--[[ vim.api.nvim_set_keymap("n", "gc", "<cmd>lua require('goto-preview').goto_preview_references()<CR> ", { noremap = true }) ]]
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-[>", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true })

--------------------------------------------------------------------------------------------------
require("neo-tree").setup({
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = false,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    sort_case_insensitive = false,
    sort_function = nil ,
    default_component_configs = {
        container = {
            enable_character_fade = true
        },
        indent = {
            indent_size = 1,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = nil,
            expander_collapsed = "",
            expander_expanded = "",

            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            default = "*",
            highlight = "NeoTreeFileIcon"

        },
        modified = {
            symbol = "",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {

                added     = "",
                modified  = "󰠠",
                conflict  = "",
                unstaged = "",
                staged = "",
                unmerged = "",
                renamed = "",
                untracked = "",
                deleted = "",
                ignored = "",
            }
        },
        file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
        },
        type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
        },
        last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
        },
        created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
        },
        symlink_target = {

            enabled = false,
        },
    },
    commands = {},
    window = {
        position = "left",
        width = 30,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = { "toggle_node", nowait = false, },
            ["<cr>"] = "open",
            ["l"] = "open",

            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["a"] = { "add", config = { show_path = "none" } },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["z"] = "toggle_hidden",
            ["."] = "toggle_hidden",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
        }
    },
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {
            },
            hide_by_pattern = {
            },
            always_show = {
                --".gitignored",
            },
            never_show = {
            },
            never_show_by_pattern = {
            },
        },
        follow_current_file = {
            enabled = false,
            leave_dirs_open = false,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = false,
        commands = {}
    },
    buffers = {
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
        group_empty_dirs = true,
        show_unloaded = true,
    },
    git_status = {
        window = {
            position = "float",
        }
    }
})
vim.keymap.set('n', '<C-s>', function() vim.cmd('Neotree toggle') end, {
    noremap = true, silent = true, desc = 'Toggle Neotree'
})

---------------------------------------------------------------------------------------------------
--formatconfig
local util = require("formatter.util")
require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        lua = {
            function()
                if util.get_current_buffer_file_name() == "special.lua" then
                    return nil
                end
                return {
                    exe = "stylua",
                    args = {
                        "--indent-type=Spaces",
                        "--indent-width=4",
                        "--column-width=130",
                        "--search-parent-directories",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
        cpp = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        '"--style={BasedOnStyle: LLVM, IndentWidth:    4, SortIncludes:  false, SpacesInParentheses : false, ReflowComments: false, SpacesInConditionalStatement:   false, SpaceBeforeRangeBasedForLoopColon: false, SpaceBeforeParens:  Never, AllowShortLambdasOnASingleLine: All, ColumnLimit: 130,}"',
                    },
                    stdin = true,
                }
            end,
        },
        c = {
            function()
                return {
                    exe = "clang-format",
                    args = {
                        '"--style={BasedOnStyle: LLVM, IndentWidth:    4, SortIncludes:  false, SpacesInParentheses : false, ReflowComments: false, SpacesInConditionalStatement:   false, SpaceBeforeRangeBasedForLoopColon: false, SpaceBeforeParens:  Never, AllowShortLambdasOnASingleLine: All, ColumnLimit: 130,}"',
                    },
                    stdin = true,
                }
            end,
        },
        go = {
            function()
                return {
                    exe = "gofmt",
                    args = {},
                    stdin = true,
                }
            end,
        },
        rust = {
            function()
                return {
                    exe = "rustfmt",
                    args = {},
                    stdin = true,
                }
            end,
        },
        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
        },
    },
})

------------------------------------------------------------------------------------------------
--termconfig 终端
require("toggleterm").setup{
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    autochdir = false,
    highlights = {
        Normal = {
            guifg="NONE",
            guibg = "NONE",
        },
        NormalFloat = {
            guifg="NONE",
            guibg="NONE",
        },
        FloatBorder = {
            guifg = "#686eaa",
            guibg = "NONE",
        },
    },
    shade_terminals = true,
    shading_factor = '-30',
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    direction = 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell,
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    float_opts = {
        border = 'curved',
        height = 25,
        width = 90,
        --[[ row = 5,
        col = 5, ]]
        winblend = 3,
        zindex = 5,
        title_pos = 'left',
    },
    winbar = {
        enabled = false,
        name_formatter = function(term)
            return term.name
        end
    },
}

----------------------------------------------------------------------------------------------
--telescopeconfig 模糊查
vim.api.nvim_set_keymap("n", "<C-m>f", "<cmd>lua require('telescope.builtin').find_files({layout_strategy='vertical',layout_config={width=0.9,height=0.7}})<cr>", {})

vim.api.nvim_set_keymap("n", "<C-m>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
vim.api.nvim_set_keymap("n", "<C-m>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", {})
vim.api.nvim_set_keymap("n", "<C-m>m", "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", {})
vim.api.nvim_set_keymap("n", "<C-m>c", "<cmd>lua require('telescope.builtin').treesitter()<cr>", {})
vim.api.nvim_set_keymap("n", "<C-m>p", "<cmd>lua require('telescope.builtin').grep_string()<cr>", {})

------------------------------------------------------------------------------------------------
--gitconfig
require('gitsigns').setup{
    signs_staged_enable = false,
    signcolumn = false,  -- Toggle with `:Gitsigns toggle_signs`
    signs = {
        add          = { text = '|' },
        change       = { text = '|' },
        delete       = { text = '|' },
        topdelete    = { text = '|' },
        changedelete = { text = '|' },
        untracked    = { text = '|' },
    },
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        map('n', 'gj', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', 'gk', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)
    end
}
vim.api.nvim_set_keymap("n", "gt", ":Gitsigns toggle_signs<cr>", po )

--------------------------------------------------------------------------------------------------
--functionconfig 函数列表
require("aerial").setup({
    backends = { "treesitter", "lsp", "markdown", "man" },
    layout = {
        max_width = { 30, 0.2 },
        width = nil,
        min_width = 30,
        win_opts = {},
        default_direction = "prefer_right",
        placement = "window",
    },
    attach_mode = "window",
    close_automatic_events = {},
    keymaps = {
        ["?"] = "actions.show_help",
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["p"] = "actions.scroll",
        ["<C-j>"] = "actions.down_and_scroll",
        ["<C-k>"] = "actions.up_and_scroll",
        ["{"] = "actions.prev",
        ["}"] = "actions.next",
        ["[["] = "actions.prev_up",
        ["]]"] = "actions.next_up",
        ["q"] = "actions.close",
        ["o"] = "actions.tree_toggle",
        ["za"] = "actions.tree_toggle",
        ["O"] = "actions.tree_toggle_recursive",
        ["zA"] = "actions.tree_toggle_recursive",
        ["l"] = "actions.tree_open",
        ["zo"] = "actions.tree_open",
        ["L"] = "actions.tree_open_recursive",
        ["zO"] = "actions.tree_open_recursive",
        ["h"] = "actions.tree_close",
        ["zc"] = "actions.tree_close",
        ["H"] = "actions.tree_close_recursive",
        ["zC"] = "actions.tree_close_recursive",
        ["zr"] = "actions.tree_increase_fold_level",
        ["zR"] = "actions.tree_open_all",
        ["zm"] = "actions.tree_decrease_fold_level",
        ["zM"] = "actions.tree_close_all",
        ["zx"] = "actions.tree_sync_folds",
        ["zX"] = "actions.tree_sync_folds",
    },
    lazy_load = true,
    disable_max_lines = 10000,
    disable_max_size = 2000000, -- Default 2MB
    filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
    },
    highlight_mode = "split_width",
    highlight_closest = true,
    highlight_on_hover = false,
    highlight_on_jump = 300,
    icons = {},
    ignore = {
        unlisted_buffers = true,
        filetypes = {},
        buftypes = "special",
        wintypes = "special",
    },
    manage_folds = false,
    link_folds_to_tree = false,
    link_tree_to_folds = true,
    nerd_font = "auto",
    open_automatic = false,
    post_jump_cmd = "normal! zz",
    close_on_select = false,
    update_events = "TextChanged,InsertLeave",
    show_guides = false,
    guides = {
        mid_item = "├─",
        last_item = "└─",
        nested_top = "│ ",
        whitespace = "  ",
    },
    float = {
        border = "rounded",
        relative = "cursor",
        max_height = 0.9,
        height = nil,
        min_height = { 8, 0.1 },
    },

    lsp = {
        diagnostics_trigger_update = true,
        update_when_errors = true,
        update_delay = 300,
    },
    treesitter = {
        update_delay = 300,
    },
    markdown = {
        update_delay = 300,
    },
    man = {
        update_delay = 300,
    },
})
vim.keymap.set("n", "gl", "<cmd>AerialToggle!<CR>")

---------------------------------------------------------------------------------------------------
--schemeconfig

require("catppuccin").setup({
    flavour = "auto",
    background = {
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        nvimtree = false,
        notify = false,
        mini = false,
    },
})
vim.cmd.colorscheme('catppuccin-frappe')

require('nvim-highlight-colors').setup({
	---@usage 'background'|'foreground'|'virtual'
	render = 'background',
	virtual_symbol = '■',
	enable_named_colors = true,
	enable_tailwind = false,
	custom_colors = {
		{ label = '%-%-theme%-primary%-color', color = '#0f1219' },
		{ label = '%-%-theme%-secondary%-color', color = '#5a5d64' },
	}
})

---------------------------------------------------------------------------------------------------
--lualineconfig 状态栏
local lualine = require('lualine')
local colors = {
    bg       = '#2A2B3C',
    fg       = '#949cbb',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local config = {
    options = {
        component_separators = '',
        section_separators = '',
        theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
}

local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    function()
        return '▊'
    end,
    color = { fg = colors.blue }, -- Sets highlighting of component
    padding = { left = 0, right = 1 }, -- We don't need space before this
}
ins_left {
    -- mode component
    function()
        return ''
    end,
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            ['_'] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 },
}
ins_left {
    'filesize',
    cond = conditions.buffer_not_empty,
}
ins_left {
    function()
        return vim.fn.fnamemodify(vim.fn.expand('%'), ':~')
    end,
    cond = conditions.buffer_not_empty,
    color = { fg = colors.fg, gui = 'NONE' },
}
ins_left { 'location' }
ins_left { 'progress', color = { fg = colors.fg, gui = 'NONE' } }

ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = '󰠠 ', hint= ' ' },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
}
ins_left {
    function()
        return '%='
    end,
}

ins_right {
    'branch',
    icon = '',
    color = { fg = colors.violet, gui = 'NONE' },
}
ins_right {
    unstaged = "󰠠",
    staged = "",
    unmerged = "",
    renamed = "",
    untracked = "",
    deleted = "",
    ignored = "",
    'diff',
    symbols = { added = ' ', modified = '󰠠 ', removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
}
ins_right {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'NONE' },
}
ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = false,
    color = { fg = colors.green, gui = 'NONE' },
}
ins_right {
    function()
        return '▊'
    end,
    color = { fg = colors.blue },
    padding = { left = 1 },
}
lualine.setup(config)

-----------------------------------------------------------------------------------------------
--bufferconfig
local bufferline = require('bufferline')
bufferline.setup {
    options = {
        --[[ modified_icon = '', ]]
        buffer_close_icon = '',

        close_icon = '󰖭',

        middle_mouse_command = nil,
        indicator = {
            icon = '▎',
            style = 'icon',
        },
        highlights = {
            fill = {
                bg = {
                    attribute = "fg",
                    highlight = "Pmenu"
                }
            }
        },
        max_name_length = 10,
        max_prefix_length = 1,
        truncate_names = false,
        tab_size = 10,
        diagnostics = false ,
        diagnostics_update_in_insert = false,
        color_icons = true , -- whether or not to add the filetype icon highlights
        show_buffer_icons = true , -- disable filetype icons for buffers
        show_buffer_close_icons = true ,
        show_close_icon = true,
        show_tab_indicators = false ,
        show_duplicate_prefix = false , -- whether to show duplicate buffer prefix
        persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
        separator_style = "slope" ,--| "slope" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = false ,
        always_show_bufferline = true ,
    },
    highlights = {
        fill                  = { bg = '#2A2B3C', fg="NONE" },--全部背景
        buffer_selected       = { fg = '#949cbb', bg = '#3B3F52', italic = true, bold = false},--活动buffer背景
        background            = { fg = '#949cbb', bg = '#333547', },--非活动buffer背景
        close_button_selected = { fg = '#949cbb', bg = '#3B3F52', },--活动按钮
        close_button          = { fg = '#949cbb', bg = '#333547', },--非活动按钮
        modified_selected     = { fg = '#87beaa', bg = '#3B3F52', },--编辑状态
        separator_selected    = { bg = '#3B3F52', fg = '#2A2B3C', },
        separator             = { bg = '#333547', fg = '#2A2B3C', },
        indicator_selected    = { bg = '#3B3F52', fg = '#2A2B3C', },
    }
}
vim.api.nvim_set_keymap("n", "<C-q>", ":BufferLineCloseOthers<cr>", {noremap = true, silent = true })

--------------------------------------------------------------------------------------------------
require("ibl").setup({
    indent = {
        char = "│",
        tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
        filetypes = {
            "help",
            "alpha",
            --[[ "dashboard", ]]
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
        },
    },
})
-------------------------------------------------------------------------------------------------
require("auto-save").setup {
}
---------------------------------------------------------------------------------------------------
require("Comment").setup({
    ignore = "^$",
    toggler = {
        line = "<leader>cc",
        block = "<leader>cc",
    },
    opleader = {
        line = "<leader>cc",
        block = "<leader>cc",
    },
})

-----------------------------------------------------------------------------------
--autoparirsconfig 括号补全
local npairs = require("nvim-autopairs")
npairs.setup({
    fast_wrap = {},
})
npairs.setup({
    fast_wrap = {
        map = "<A-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment",
    },
})
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

require("nvim-autopairs").setup({
    enable_check_bracket_line = false,
})

---------------------------------------------------------------------------------------------------
--[[ vim.g.translator_window_borderchars = {'─','│','─','│','╭','╮','╯','╰'}

vim.g.translator_window_type="popup"
vim.g.translator_window_max_width=0.8
vim.g.translator_window_max_height=0.6
--vim.g.translator_target_lang="google"
vim.api.nvim_set_keymap("n", "<leader>t", "<Plug>TranslateW", po )
vim.api.nvim_set_keymap("x", "<leader>t", "<Plug>TranslateWV", po ) ]]


-------------------------------------------------------------------------------------------------
--自定义快捷键
--keyconfig
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", po)
vim.api.nvim_set_keymap("n", "<C-p>", ":bp<CR>", po)
vim.api.nvim_set_keymap("n", "<C-n>", ":bn<CR>", po)
vim.api.nvim_set_keymap("n", "<C-k>", ":bd<CR>", po)

vim.api.nvim_set_keymap("n", "w", "E", po)
vim.api.nvim_set_keymap("n", "e", "gE", po)

vim.api.nvim_set_keymap("n", "q", ":nohl<CR>", po)

vim.api.nvim_set_keymap("n", "<C-y>", '"+yy', po)
vim.api.nvim_set_keymap("v", "<C-y>", '"+y', po)
vim.api.nvim_set_keymap("n", "<C-e>", '"+p', po)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>w", po)

vim.api.nvim_set_keymap("n", "zl", "5<C-w><", po)
vim.api.nvim_set_keymap("n", "zh", "5<C-w>>", po)

vim.api.nvim_set_hl(0, 'myor', {bg = '#7f869e', fg = 'NONE' })
vim.opt.guicursor = {
    "n-v-c-sm:block-myor",
    "i-ci-ve:ver25-myor",
    "r-cr-o:hor20-myor",
    "t:block-myor"
}

vim.api.nvim_set_hl(0, 'Structure',         { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'Statement',         { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'Boolean',           { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'Repeat',            { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'Conditional',       { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'cppExceptions',     { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'Keyword',           { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'StorageClass',      { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'Operator',          { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'cLabel',            { fg = '#317272', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, '@keyword.function', { fg = '#317272', bg = 'NONE', italic = false })

vim.api.nvim_set_hl(0,'@lsp.type.Namespace',               {fg='#B766AD',bg= 'NONE', italic= false })
vim.api.nvim_set_hl(0,'@lsp.type.Class',                   {fg='#Ca7a5a',bg= 'NONE', italic= false })
vim.api.nvim_set_hl(0,'@lsp.typemod.class.defaultLibrary', {fg='#Ca7a5a',bg= 'NONE', italic= false })
vim.api.nvim_set_hl(0, 'Type',                             {fg='#D55F6F',bg= 'NONE', italic= false })
vim.api.nvim_set_hl(0, '@type.builtin',                    {fg='#D55F6F',bg= 'NONE', italic= false })

vim.api.nvim_set_hl(0,'@variable.builtin',      {fg= '#9F6680',bg= 'NONE', italic=false })--cout cin
vim.api.nvim_set_hl(0,'@lsp.type.TypeParameter',{fg= '#9F6680',bg= 'NONE', italic=false })--模板参数
vim.api.nvim_set_hl(0,'@lsp.type.variable',     {fg= '#9F6680',bg= 'NONE', italic=false })--变量
vim.api.nvim_set_hl(0,'@lsp.type.parameter',    {fg= '#749395',bg= 'NONE', italic=false })--函数变量
vim.api.nvim_set_hl(0,'@lsp.type.property',     {fg= '#7C73B0',bg= 'NONE', italic=false })--类成员变量

vim.api.nvim_set_hl(0, '@lsp.type.Function',                    { fg = '#4683C1', bg = 'NONE' })--函数
vim.api.nvim_set_hl(0, '@lsp.typemod.function.defaultLibrary',  { fg = '#4683C1', bg = 'NONE' })
vim.api.nvim_set_hl(0, '@lsp.typemod.method.defaultLibrary',    { fg = '#4683C1', bg = 'NONE' })
vim.api.nvim_set_hl(0, '@lsp.type.method',                      { fg = '#4683C1', bg = 'NONE' })--方法
vim.api.nvim_set_hl(0,'@lsp.typemod.unknown.dependentName.cpp', { fg = '#4683C1', bg = 'NONE' })--方法

vim.api.nvim_set_hl(0, 'LspInlayHint',  { fg = '#1a1c26', bg= 'NONE', italic= false })
vim.api.nvim_set_hl(0, 'Comment',       { fg = '#676E95', bg = 'NONE', italic=false })--注释
vim.api.nvim_set_hl(0, 'Character',     { fg = '#676E95', bg = 'NONE', italic=false })
vim.api.nvim_set_hl(0, 'String',        { fg = '#676E95', bg = 'NONE', italic=false })--字符串
vim.api.nvim_set_hl(0, 'Special',       { fg = '#676E95', bg = 'NONE', italic=false })--\n
vim.api.nvim_set_hl(0, '@string.escape',{ fg = '#676E95', bg = 'NONE', italic=false })--lua \n

vim.api.nvim_set_hl(0, 'cPreCondit',      { fg = '#D55F6F', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'cDefine',         { fg = '#D55F6F', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'Macro',           { fg = '#D55F6F', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'PreProc',         { fg = '#D55F6F', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'include',         { fg = '#D55F6F', bg = 'NONE', italic = false })
vim.api.nvim_set_hl(0, 'Number',          { fg = '#7C73B0', bg = 'NONE', italic = false })

vim.api.nvim_set_hl(0, '@constant.macro',      { fg = '#B03060', bg = 'NONE', italic = true })--宏定义
vim.api.nvim_set_hl(0, '@lsp.type.enumMember', { fg = '#E5C890', bg = 'NONE', italic = true })--枚举


vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = '#4683C1', bg = 'NONE', italic =false})--补全匹配字符
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch',      { fg = '#4683C1', bg = 'NONE', italic =false})

vim.api.nvim_set_hl(0, 'CmpItemMenu', { fg = '#676E95', bg = 'NONE'})           --lsp snipp lua buff...
vim.api.nvim_set_hl(0, 'PmenuSel',    { bg = '#3B3F52', fg = 'NONE',italic=false}) --选中项
vim.api.nvim_set_hl(0, 'Visual',      { bg = '#585D73', fg = 'NONE',italic=false})
