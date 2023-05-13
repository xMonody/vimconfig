local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    { "folke/lazy.nvim" },
    { "williamboman/mason.nvim" },

    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "saecki/crates.nvim", version = "v0.3.0", dependencies = { "nvim-lua/plenary.nvim" } },
    --[[ { "hrsh7th/cmp-nvim-lsp-signature-help" }, ]]
    {"ray-x/lsp_signature.nvim"},
    { "rmagatti/goto-preview" },

    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },

    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },

    {"dinhhuy258/sfm.nvim",dependencies={"dinhhuy258/sfm-fs.nvim", --树目录
    "dinhhuy258/sfm-filter.nvim","dinhhuy258/sfm-git.nvim"}},

    { "akinsho/toggleterm.nvim" },--终端
    --{ "voldikss/vim-floaterm" },

    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, --模糊搜索
    { "lewis6991/gitsigns.nvim" }, --git修改
    { "stevearc/aerial.nvim" }, --大纲
    --"nvim-treesitter/nvim-treesitter", --高亮

    { "navarasu/onedark.nvim" },--主题
    { "mhartington/formatter.nvim" },--格式化

    { "nvim-lualine/lualine.nvim" }, --状态栏
    --{'romgrk/barbar.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},

    { "lukas-reineke/indent-blankline.nvim" }, --对齐线
    { "RRethy/vim-illuminate" },--突出光标下单词

    { "numToStr/Comment.nvim" }, --注释
    { "windwp/nvim-autopairs" }, --括号补全
    { "Pocco81/auto-save.nvim" }, --自动保存
}


require("lazy").setup(plugins,{
    install = {
        missing = true,
        colorscheme = { "lunaperche" },
    },
    ui = {
        icons = {
        loaded = " ",
        not_loaded = " ",
        list = {
            "●",
            "➜",
            "➜",
            "➜",
        },
    },
        size = { width = 0.8, height = 0.8 },
        wrap = false,
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
    },
})

vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true --设置tab=空格
vim.o.scrolloff = 6
vim.o.pumheight = 10
vim.wo.numberwidth = 1
vim.o.laststatus=0
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
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 200
vim.wo.signcolumn = "yes"
vim.o.cmdheight = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true
vim.o.backspace = "indent,eol,start" --设置back键
vim.opt.completeopt = "menu,menuone,noinsert"
vim.api.nvim_create_autocmd( --回车不注释
{ "FileType" },
{
    command = "set formatoptions-=ro",
}
)

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

---------------------------------------------------------------------------------------------------
require("mason").setup({
    ui = {
        border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"},
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
---------------------------------------------------------------------------------------------------

vim.keymap.set('n', 'gf', vim.diagnostic.open_float)
vim.keymap.set('n', 'gn', vim.diagnostic.goto_prev)
vim.keymap.set('n', 'gp', vim.diagnostic.goto_next)
vim.keymap.set('n', 'gs', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.rename, opts)
    end,
})

---------------------------------------------------------------------------------------------------
local border = {
    {"╭", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╮", "FloatBorder"},
    {"│", "FloatBorder"},
    {"╯", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╰", "FloatBorder"},
    {"│", "FloatBorder"},
}
local handlers =  {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border }),
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.cmd [[autocmd ColorScheme * highlight NormalFloat guifg=NONE guibg=NONE]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=NONE guibg=NONE]]

--在悬停窗口中自动显示线路诊断
local signs = { Error = "", Warn = "", Hint = "", Info = "ﴞ" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

-- LSP settings (for overriding per client)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_flags = {
    debounce_text_changes = 150,
}

local lsp1 = require 'lspconfig'
local servers = { 'rust_analyzer',}
for _, lsp in ipairs(servers) do
    lsp1[lsp].setup {
        handlers=handlers,
        flags = lsp_flags,
        --[[ on_attach = on_attach, ]]
        capabilities = capabilities,
    }
end

lsp1.clangd.setup{
    cmd={"clangd",
        "--header-insertion=never"
    },
    handlers=handlers,
    flags = lsp_flags,
    --[[ on_attach = on_attach, ]]
    capabilities = capabilities,
}

lsp1.cmake.setup{
    handlers=handlers,
    flags = lsp_flags,
    --[[ on_attach = on_attach, ]]
    capabilities = capabilities,
    cmd={"cmake-language-server"},
}

lsp1.lua_ls.setup {
    handlers=handlers,
    --[[ on_attach = on_attach, ]]
    capabilities = capabilities,
    settings = {
        Lua = {
            completion = {
                callSnippet = 'Replace',
            },
            runtime = { version = 'LuaJIT' },
            hint = {
                enable = true,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
}

require("lspconfig").gopls.setup({
    handlers=handlers,
    flags = lsp_flags,
    --[[ on_attach = on_attach, ]]
    capabilities = capabilities,
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
    },
})

---------------------------------------------------------------------------------------------------
-- luasnip setup
local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

local ELLIPSIS_CHAR = "…"
local MAX_LABEL_WIDTH = 40

local luasnip = require("luasnip")

--require("luasnip.loaders.from_vscode").lazy_load({paths={"D:/gitdir/vimconfig/mysnip"}})
require("luasnip.loaders.from_vscode").lazy_load({paths={"~/vimconfig/mysnip"}})

--[[ local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end ]]

--cmpconfig
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
        documentation=cmp.config.disable,
        --[[documentation = {
        border = border("CmpDocBorder"),
        max_width = 40,
        max_height = 10,
        winhighlight = "FloatBorder:CmpPmenu,:PmenuSel,Search:None",
        },]]--

        --[[completion = {
        border = border "CmpDocBorder",
        col_offset=0,
        side_padding=0,
        max_width=100,
        max_height=110,
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
        }, ]]
    },

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

        ["<C-k>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
    },


    sources = {
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        --[[ { name = "nvim_lsp_signature_help" }, ]]
        { name = "crates" },
    },

    view = {
        entries = { name = "custom" },
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
                nvim_lsp = "[LSP]",
                luasnip = "[Snp]",
                buffer = "[Buf]",
                paht = "[Pat]",
                nvim_lua = "[Lua]",
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
---------------------------------------------------------------------------------------------------

local cfg = {
    debug = false, -- set to true to enable debug logging
    log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
    verbose = false, -- show debug line number
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    doc_lines = 3, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    max_height = 12, -- max height of signature floating_window
    max_width = 80, -- max_width of signature floating_window
    noice = false, -- set to true if you using noice to render markdown
    wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    floating_window_off_x = 1, -- adjust float windows x position. 
    floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
    close_timeout = 4000, -- close floating window after ms when laster parameter is entered
    fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = "",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
    },

    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

--------------------------------------------------------------------------------------------------
--gotoconfig
require("goto-preview").setup({
    width = 100, -- Width of the floating window
    height = 17, -- Height of the floating window
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    default_mappings = false, -- Bind default mappings
    debug = false, -- Print debug information
    opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
    resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
    post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
    focus_on_open = true, -- Focus the floating window when opening it.
    dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
    force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
    bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
})

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })
--[[ vim.api.nvim_set_keymap("n", "gc", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true }) ]]
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-[>", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true })

---------------------------------------------------------------------------------------------------
--[[ require("nvim-treesitter.install").prefer_git = true
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp","lua", "vim", "rust"},
    sync_install = false,

    auto_install = true,

    ignore_install = { },

    highlight = {
        enable = true,

        disable = function(lang, buf)
            local max_filesize = 100 * 2048-- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        additional_vim_regex_highlighting = false,
    },
} ]]
---------------------------------------------------------------------------------------------------

--[[ require("nvim-tree").setup({ -- BEGIN_DEFAULT_OPTS
auto_reload_on_write = true,
create_in_closed_folder = false,
disable_netrw = false,
hijack_cursor = false,
hijack_netrw = true,
hijack_unnamed_buffer_when_opening = false,
sort_by = "name",
root_dirs = {},
prefer_startup_root = false,
sync_root_with_cwd = false,
reload_on_bufenter = false,
respect_buf_cwd = false,
on_attach = "disable",
remove_keymaps = false,
select_prompts = false,
view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    hide_root_folder = false,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
        custom_only = false,
        list = {

        },
    },
    float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
        },
    },
},
renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    indent_width = 2,
    indent_markers = {
        enable = false,
        inline_arrows = true,
        icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
        },
    },
    icons = {
        webdev_colors = true,
        git_placement = "before",
        padding = " ",
        symlink_arrow = " ➛ ",
        show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
        },
        glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
            },
            git = {
                unstaged = "ﴞ",
                staged = "",
                unmerged = "",
                renamed = "",
                untracked = "",
                deleted = "",
                ignored = ""
            },
        },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    symlink_destination = true,
},
hijack_directories = {
    enable = true,
    auto_open = true,
},
update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
},
system_open = {
    cmd = "",
    args = {},
},
diagnostics = {
    enable = false,
    show_on_dirs = false,
    debounce_delay = 50,
    icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    },
},
filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
},
filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
    ignore_dirs = {},
},
git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 400,
},
actions = {
    use_system_clipboard = true,
    change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
    },
    expand_all = {
        max_folder_discovery = 300,
        exclude = {},
    },
    file_popup = {
        open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
        },
    },
    open_file = {
        quit_on_open = false,
        resize_window = true,
        window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
            },
        },
    },
    remove_file = {
        close_window = true,
    },
},
trash = {
    cmd = "gio trash",
    require_confirm = true,
},
live_filter = {
    prefix = "",
    always_show_folders = true,
},
log = {
    enable = false,
    truncate = false,
    types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
    },
},
notify = {
    threshold = vim.log.levels.INFO,
},
})
vim.api.nvim_set_keymap("n", "<C-s>", '<cmd> NvimTreeToggle()<CR>', { noremap = true }) ]]

--------------------------------------------------------------------------------------------------
local sfm_explorer=require("sfm").setup{
    mappings = {
        list = {
            {
                key = "l",
                action = "edit",
            },
            {
                key = "cr",
                action = "edit",
            },
        },
    },
}
sfm_explorer:load_extension "sfm-filter"

sfm_explorer:load_extension ("sfm-fs",{
    mappings = {
        list = {
            {
                key = "a",
                action = "create",
            },
        },
    },
})

sfm_explorer:load_extension("sfm-git",{
    debounce_interval_ms = 100,
    icons = {
        unstaged = "ﴞ",
        staged = "",
        unmerged = "",
        renamed = "",
        untracked = "",
        deleted = "",
        ignored = ""
    }
})

vim.api.nvim_set_keymap("n", "<C-s>", '<cmd> SFMToggle<CR>', { noremap = true })

---------------------------------------------------------------------------------------------------
--formatconfig
local util = require("formatter.util")
require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
        lua = {
            require("formatter.filetypes.lua").stylua,
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
                        "--stdin-filepath",
                        util.escape_path(util.get_current_buffer_file_path()),
                        "--",
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
                        '"-style={BasedOnStyle: LLVM, IndentWidth:    4, SortIncludes:  false, SpacesInParentheses : false, ReflowComments: false, ReflowComments: false, SpacesInConditionalStatement:   false, SpaceBeforeRangeBasedForLoopColon: false, SpaceBeforeParens:  Never, AllowShortLambdasOnASingleLine: All, ColumnLimit: 130,}"',
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
                        '"-style={BasedOnStyle: LLVM, IndentWidth:    4, SortIncludes:  false, SpacesInParentheses : false, ReflowComments: false, ReflowComments: false, SpacesInConditionalStatement:   false, SpaceBeforeRangeBasedForLoopColon: false, SpaceBeforeParens:  Never, AllowShortLambdasOnASingleLine: All, ColumnLimit: 130,}"',
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
    size=19,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    autochdir = false,
    highlights = {
        Normal = {
            guibg = 'NONE',
            guifg = 'NONE',
        },
        NormalFloat = {
            guibg = 'NONE',
            guifg = 'NONE',
        },
        FloatBorder = {
            guifg = "NONE",
            guibg = "NONE",
        },
    },
    shade_terminals = true,
    shading_factor = '-30',
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
    float_opts = {
        border = 'curved',
        width = 119,
        height = 29,
        winblend = 1,
        zindex = 10,
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
vim.api.nvim_set_keymap("n", "<C-m>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", {})
vim.api.nvim_set_keymap("n", "<C-m>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>", {})
vim.api.nvim_set_keymap("n", "<C-m>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", {})
vim.api.nvim_set_keymap("n", "<C-m>m", "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", {})
vim.api.nvim_set_keymap("n", "gc", "<cmd>lua require('telescope.builtin').lsp_references({layout_config={width=0.99,height=0.99}})<cr>",{})
vim.api.nvim_set_keymap("n", "<C-m>c", "<cmd>lua require('telescope.builtin').treesitter()<cr>", {})
vim.api.nvim_set_keymap("n", "<C-m>p", "<cmd>lua require('telescope.builtin').grep_string()<cr>", {})

------------------------------------------------------------------------------------------------
--gitconfig
require("gitsigns").setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "|", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "|", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "|", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        interval = 1000,
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigati on
        map("n", "tj", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        map("n", "tk", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true })

        --map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        --map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        --map('n', '<leader>hS', gs.stage_buffer)
        --map('n', '<leader>hu', gs.undo_stage_hunk)
        --map('n', '<leader>hR', gs.reset_buffer)
        map("n", "tv", gs.preview_hunk)
        map("n", "tb", function()
            gs.blame_line({ full = true })
        end)
        -- map('n', '<leader>tb', gs.toggle_current_line_blame)
        map("n", "td", gs.diffthis)
        --map('n', '<leader>td', gs.toggle_deleted)
    end,
})
--------------------------------------------------------------------------------------------------
--functionconfig 函数列表
require("aerial").setup({
    backends = { "treesitter", "lsp", "markdown", "man" },
    layout = {
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 40,
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
vim.keymap.set("n", "<C-m>o", "<cmd>AerialToggle!<CR>")

---------------------------------------------------------------------------------------------------
--schemeconfig
require("onedark").setup({
    -- Main options --
    style = "deep", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
    toggle_style_key = "<leader>cs",
    toggle_style_list = { "darker", "cool", "deep", "warmer", "warm", "warmer", "light" }, -- List of styles to toggle between
    code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
    },
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
    },
})
vim.cmd([[colorscheme onedark]])

---------------------------------------------------------------------------------------------------
--lualineconfig 状态栏
local lualine = require("lualine")
local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
}
local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}
local config = {
    options = {
        component_separators = "",
        section_separators = "",
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
ins_left({
    function()
        return "▊"
    end,
    color = { fg = colors.blue }, -- Sets highlighting of component
    padding = { left = 0, right = 1 }, -- We don't need space before this
})
ins_left({
    function()
        return ""
    end,
    color = function()
        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [""] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [""] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ["r?"] = colors.cyan,
            ["!"] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 },
})
ins_left({
    "filesize",
    cond = conditions.buffer_not_empty,
})
ins_left({
    "filename",
    cond = conditions.buffer_not_empty,
    color = { fg = colors.magenta, gui = "bold" },
})
ins_left({ "location" })
ins_left({ "progress", color = { fg = colors.fg, gui = "bold" } })
ins_left({
    "diagnostics",
    sources = { "nvim_diagnostic" }, -- Error = "", Warn = "", Hint = "", Info = "ﴞ"
    symbols = { error = " ", warn = " ", info = "ﴞ ", hint = " " },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
})
ins_left({
    function()
        return "%="
    end,
})
ins_left({
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = "",
    color = { fg = "#ffffff", gui = "bold" },
})
ins_right({
    "o:encoding",
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = "bold" },
})
ins_right({
    "fileformat",
    fmt = string.upper,
    icons_enabled = false,
    color = { fg = colors.green, gui = "bold" },
})
ins_right({
    "branch",
    icon = "",
    color = { fg = colors.violet, gui = "bold" },
})
ins_right({
    "diff",
    symbols = { added = " ", modified = " ",removed = " " },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
})
ins_right({
    function()
        return "▊"
    end,
    color = { fg = colors.blue },
    padding = { left = 1 },
})
lualine.setup(config)

-----------------------------------------------------------------------------------------------
--bufferconfig
local bufferline = require('bufferline')
bufferline.setup {
    options = {
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
        buffer_close_icon = '',
        modified_icon = '',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 13,
        max_prefix_length = 10,
        truncate_names = true,
        tab_size = 10,
        diagnostics = false ,
        diagnostics_update_in_insert = false,
        color_icons = true , -- whether or not to add the filetype icon highlights
        show_buffer_icons = true , -- disable filetype icons for buffers
        show_buffer_close_icons = true ,
        show_close_icon = true ,
        show_tab_indicators = true ,
        show_duplicate_prefix = true , -- whether to show duplicate buffer prefix
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = "slope" ,--| "slope" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = false ,
        always_show_bufferline = true ,
    }
}

--------------------------------------------------------------------------------------------------
require("indent_blankline").setup({
    show_end_of_line = true,
    space_char_blankline = " ",
})
-------------------------------------------------------------------------------------------------
require("auto-save").setup {
}
--------------------------------------------------------------------------------------------------

-- default configuration
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirvish',
        'fugitive',
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
    large_file_cutoff = nil,
    large_file_overrides = nil,
    min_count_to_highlight = 1,
})

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

local po={noremap = true, silent = true }


--[[vim.g.floaterm_shell='powershell'
vim.g.floaterm_borderchars = '─│─│╭╮╯╰ '
vim.g.floaterm_title = ''
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.9
vim.api.nvim_set_keymap("t", "<C-\\>", "<C-\\><C-n>:FloatermKill<CR>", po )
vim.api.nvim_set_keymap("n", "<C-\\>", ":FloatermNew --height=0.9 --width=0.8 --name=xiaobin<CR>", po)
--]]


-------------------------------------------------------------------------------------------------
--自定义快捷键
--keyconfig
vim.api.nvim_set_keymap("i", "<C-l>", "<Right>", po)
vim.api.nvim_set_keymap("n", "<C-h>", ":bp<CR>", po)
vim.api.nvim_set_keymap("n", "<C-l>", ":bn<CR>", po)
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
