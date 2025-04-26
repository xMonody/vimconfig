local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
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
    { "ray-x/lsp_signature.nvim" },
    { "rmagatti/goto-preview" },

    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },

    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-cmdline" },

    { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies =
    { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", } },

    { "akinsho/toggleterm.nvim" }, --终端
    {"voldikss/vim-translator"}, --翻译

    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, --模糊搜索
    --[[ { "lewis6991/gitsigns.nvim" }, --git修改 ]]
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

    { 'nvimdev/dashboard-nvim', config = function() require('dashboard').setup { } end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}} },
}


require("lazy").setup(plugins,{
    install = {
        missing = true,
        colorscheme = { "lunaperche" },
    },
    ui = {
        icons = {
        loaded = "󰄳 ",
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

  if is_wayland and vim.fn.executable('wl-copy') == 1 then -- Wayland优先 即使同时安装了xclip
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

---- 配置检查（调试用）
--vim.api.nvim_create_user_command('CheckClipboard', function()
  --print('当前剪贴板配置:')
  --print(vim.inspect(vim.g.clipboard))
  --print('\n环境检测:')
  --print('Wayland:', vim.env.WAYLAND_DISPLAY or 'nil')
  --print('XDG_SESSION_TYPE:', vim.env.XDG_SESSION_TYPE or 'nil')
  --print('DISPLAY:', vim.env.DISPLAY or 'nil')
  --print('可用工具:')
  --print('wl-copy:', vim.fn.executable('wl-copy'))
  --print('xclip:', vim.fn.executable('xclip'))
  --print('win32yank:', vim.fn.executable('win32yank'))
--end, {})

vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true --设置tab=空格
vim.o.scrolloff = 6
vim.o.pumheight = 10
vim.wo.numberwidth = 1
vim.o.laststatus=1
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

--[[ vim.api.nvim_create_autocmd( --回车不注释
{ "FileType" },
{
    command = "set formatoptions-=ro",
}) ]]

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove("r")
        vim.opt_local.formatoptions:remove("o")
    end,
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = {"*.frag", "*.vert"},
    callback = function()
        vim.bo.filetype = "glsl"
    end
})

vim.opt.viewoptions:append("cursor")
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    command = "silent! normal! g`\""
})

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    callback = function()
        vim.schedule(function()
            vim.cmd("redraw")
        end)
    end
})

if vim.g.guicursor ~= "" then
    vim.o.guifont = "SauceCodePro Nerd Font Mono:h15"
end

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
        vim.keymap.set('n', 'gf', vim.diagnostic.open_float)
        vim.keymap.set('n', 'gl', vim.diagnostic.setloclist)
          vim.keymap.set( 'n', 'gm', '<cmd>lua vim.diagnostic.open_float(nil, { scope = "buffer", })<cr>', { desc = 'Show buffer diagnostics' }
  )
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

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts)
  opts = opts or {}  -- 确保 opts 为非 nil，若为 nil 则赋值为空表
  opts.border = opts.border or border  -- 如果 opts 没有指定 border，则使用 'single' 作为默认边框样式
  return orig_util_open_floating_preview(contents, syntax, opts)
end

--[[ local lines = {}
vim.lsp.util.open_floating_preview(lines, "plaintext", {
    border = "single",
    max_width = 60,
    max_height = 12,
    focusable = true,
}) ]]



vim.cmd [[autocmd ColorScheme * highlight NormalFloat guifg=NONE guibg=NONE]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=NONE guibg=NONE]]

--在悬停窗口中自动显示线路诊断
local signs = { Error = "", Warn = "", Hint = "", Info = "󰠠" }
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
lsp1.clangd.setup{
    cmd={ "clangd",
        "--header-insertion=never",
        "--header-insertion-decorators=false"
    },
    --[[ handlers=handlers, ]]
    flags = lsp_flags,
    --[[ on_attach = on_attach, ]]
    capabilities = capabilities,
}

--[[lsp1.glsl_analyzer.setup{
    cmd={"glsl_analyzer"},
    filetypes = { 'glsl', 'vert', 'tesc', 'tese', 'frag', 'geom', 'comp' },
}]]

lsp1.rust_analyzer.setup{
    --[[ handlers=handlers, ]]
    flags = lsp_flags,
    capabilities = capabilities,
}

lsp1.cmake.setup{
    --[[ handlers=handlers, ]]
    flags = lsp_flags,
    capabilities = capabilities,
}

lsp1.lua_ls.setup {
    --[[ handlers=handlers, ]]
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
    --[[ handlers=handlers, ]]
    flags = lsp_flags,
    capabilities = capabilities,
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
    },
})


local cfg = {
  floating_window_off_x = 0,
  floating_window_off_y = function()
    --[[ local linenr = vim.api.nvim_win_get_cursor(0)[1] ]]
    local pumheight = vim.o.pumheight
    local winline = vim.fn.winline()
    local winheight = vim.fn.winheight(0)

    -- window top
    if winline - 1 < pumheight then
      return pumheight-10
    end

    -- window bottom
    if winheight - winline < pumheight then
      return -pumheight+10
    end
    return 0
  end,
  hint_enable = false,
  doc_lines = 1,
  max_height = 4,
  max_width = 80,
    toggle_key = '<C-d>',
    toggle_key_flip_floatwin_setting = true,
    select_signature_key = '<C-u>',
}
require "lsp_signature".setup(cfg)


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
local MAX_LABEL_WIDTH = 45

local luasnip = require("luasnip")
if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    require("luasnip.loaders.from_vscode").lazy_load({paths={"D:/vimconfig/mysnip"}})
else
    require("luasnip.loaders.from_vscode").lazy_load({paths={"~/vimconfig/mysnip"}})
end

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
        --[[ completion = cmp.config.window.bordered(), ]]
        documentation=cmp.config.disable,
        --[[ documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            max_width = 40,
            max_height = 10,
            winhighlight = "FloatBorder:CmpPmenu,:PmenuSel,Search:None",
        }, ]]

        completion = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            col_offset=0,
            side_padding=0,
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
            completeopt = "menu,menuone,preview,noinsert",
        },
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


--------------------------------------------------------------------------------------------------
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
vim.api.nvim_set_keymap("n", "gc", "<cmd>lua require('goto-preview').goto_preview_references()<CR> ", { noremap = true })
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-[>", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true })

--------------------------------------------------------------------------------------------------
require("neo-tree").setup({
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = false,
    enable_diagnostics = false,
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    sort_case_insensitive = false,
    sort_function = nil ,
    default_component_configs = {
        container = {
            enable_character_fade = true
        },

        indent = {
            indent_size = 2,
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
            ["z"] = "close_all_nodes",
            ["a"] = { "add", config = { show_path = "none" } },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",

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
window = {
    mappings = {
        --[[ ["<bs>"] = "navigate_up", ]]
        --[[ ["."] = "set_root", ]]
        ["."] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",

    },
    fuzzy_finder_mappings = {
        ["<down>"] = "move_cursor_down",
        ["<C-n>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
        ["<C-p>"] = "move_cursor_up",
    },
          },


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
vim.cmd([[nnoremap <C-s> :Neotree toggle<cr>]])

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
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  autochdir = false,
  highlights = {
    Normal = {
      guibg = "NONE",
    },
    NormalFloat = {
      link = 'NONE',
    },
    FloatBorder = {
      guifg = "#f0c6c6",
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
   -- Change the default shell. Can be a string or a function returning a string
  shell = vim.o.shell,
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
  -- This field is only relevant if direction is set to 'float'
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
--[[ require('gitsigns').setup{
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

        map('n', 'tk', function()
            if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', 'tj', function()
            if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hu', gitsigns.undo_stage_hunk)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>hd', gitsigns.diffthis)
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
        map('n', '<leader>td', gitsigns.toggle_deleted)
    end
} ]]

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
vim.keymap.set("n", "<leader>s", "<cmd>AerialToggle!<CR>")

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
vim.cmd([[colorscheme catppuccin-frappe]])
--vim.cmd([[colorscheme catppuccin-latte]])

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
  --[[ bg       = '#202328', ]]
  bg       = '#1a1c26',
  fg       = '#bbc2cf',
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
      [''] = colors.blue,
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
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }
ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }
ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = '󰠠 ', hint= '' },
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
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
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
        max_name_length = 15,
        max_prefix_length = 10,
        truncate_names = true,
        tab_size = 13,
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
vim.api.nvim_set_keymap("n", "<C-q>", ":BufferLineCloseOthers<cr>", {noremap = true, silent = true })

--------------------------------------------------------------------------------------------------
require("ibl").setup({
-- │
indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
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
--------------------------------------------------------------------------------------------------

--[[ require('illuminate').configure({
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    delay = 100,
    filetype_overrides = {},
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
}) ]]

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

vim.g.translator_window_borderchars = {'─','│','─','│','╭','╮','╯','╰'}

vim.g.translator_window_type="popup"
vim.g.translator_window_max_width=0.8
vim.g.translator_window_max_height=0.6
--vim.g.translator_target_lang="google"
vim.api.nvim_set_keymap("n", "<leader>t", "<Plug>TranslateW", po )
vim.api.nvim_set_keymap("x", "<leader>t", "<Plug>TranslateWV", po )


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


vim.cmd([[ 
hi Type            guifg=#009999 guibg=NONE gui=NONE cterm=NONE

hi @lsp.type.Class     guifg=#ff9999 guibg=NONE 
hi @lsp.typemod.class.defaultLibrary  guifg=#ff9999 "std:: function "类名

hi Structure       guifg=#F7768E guibg=NONE "calss typename"
hi @lsp.type.Namespace guifg=#ff69b4

hi @lsp.type.TypeParameter guifg=#006699 "模板参数
hi @lsp.type.parameter guifg=#eed49f gui=italic cterm=italic"函数形参
hi @lsp.type.variable  guifg=#eed49f gui=italic cterm=italic
hi @lsp.type.property  guifg=#eed49f gui=italic cterm=italic

hi @lsp.type.Function  guifg=#68a0e1 guibg=NONE
hi @lsp.typemod.function.defaultLibrary guifg=#68a0e1
hi @lsp.typemod.method.defaultLibrary   guifg=#68a0e1

hi Statement guifg=#48decc guibg=NONE gui=NONE cterm=NONE
hi Boolean guifg=#48decc guibg=NONE gui=NONE cterm=NONE
hi Repeat guifg=#48decc guibg=NONE gui=NONE cterm=NONE
hi Conditional guifg=#48decc guibg=NONE gui=NONE cterm=NONE

hi Constant guifg=#ffa0a0 guibg=NONE gui=NONE cterm=NONE

hi Comment   guifg=#676e95 guibg=NONE cterm=italic gui=italic
hi Character guifg=#676e95 guibg=NONE gui=italic cterm=italic
hi String    guifg=#676e95 guibg=NONE gui=italic cterm=italic

hi Macro guifg=#f7768e gui=italic
hi PreProc guifg=#006699 guibg=NONE gui=NONE cterm=NONE
hi Define  guifg=#F7768E cterm=italic gui=italic
hi include guifg=#ff9999
hi CmpItemAbbrMatch guibg=NONE guifg=#68a0e1 gui=NONE
hi CmpItemMenu guibg=NONE guifg=#f7768e gui=NONE
hi Visual guifg=#f78c6c guibg=#686e95 gui=NONE ctermfg=NONE ctermbg=209 cterm=NONE

]])

--[[ hi CursorLine gui=NONE guifg=NONE guibg=#364a82 ]]
