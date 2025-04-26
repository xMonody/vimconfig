local wezterm = require("wezterm")
local act = wezterm.action
local action_callback = wezterm.action_callback

local fonts="SauceCodePro Nerd Font Mono"
local size=20
local msys="C:/msys64/msys2_shell.cmd"

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    return "Wezterm"
end)

local nf = wezterm.nerdfonts
local GLYPH_SEMI_CIRCLE_LEFT = nf.ple_left_half_circle_thick
local GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick
--local GLYPH_SEMI_CIRCLE_LEFT = ""
--local GLYPH_SEMI_CIRCLE_RIGHT = ""

local M = {}
local __cells__ = {}

local colors = {
   default   = { bg = '#49556a', fg = '#1c1b19' },
   is_active = { bg = '#68a0e1', fg = '#11111b' },
   hover     = { bg = '#587d8c', fg = '#1c1b19' },
}

local _set_process_name = function(s)
   local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

local _set_title = function(process_name, base_title, max_width, inset)
    local title = ""  -- 我们不需要使用 max_width 和 inset 参数了，因为固定为5字符

    if process_name:len() > 0 then -- 只使用进程名，忽略 base_title(路径)
        if process_name:len() > 5 then -- 处理进程名：取前5个字符
            title = process_name:sub(1, 4) .. "~"
        else
            title = process_name .. string.rep(" ", 5 - process_name:len())
        end
    else
        title = "     " -- 如果没有进程名，显示5个空格
    end
    return title
end


local _check_if_admin = function(p)
   if p:match('^Administrator: ') then
      return true
   end
   return false
end

local _push = function(bg, fg, attribute, text)
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Attribute = attribute })
   table.insert(__cells__, { Text = text })
end

wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, hover, max_width)
    __cells__ = {}
    local bg
    local fg
    local process_name = _set_process_name(tab.active_pane.foreground_process_name)
    local is_admin = _check_if_admin(tab.active_pane.title)
    local title = _set_title(process_name, tab.active_pane.title, max_width, (is_admin and 8))

    if tab.is_active then
        bg = colors.is_active.bg
        fg = colors.is_active.fg
    elseif hover then
        bg = colors.hover.bg
        fg = colors.hover.fg
    else
        bg = colors.default.bg
        fg = colors.default.fg
    end
    local has_unseen_output = false
    for _, pane in ipairs(tab.panes) do
        if pane.has_unseen_output then
            has_unseen_output = true
            break
        end
    end
    -- rgb(36, 40, 59)
    _push('rgb(51,51,51)', bg, { Intensity = 'Normal' }, " " .. GLYPH_SEMI_CIRCLE_LEFT)
    _push(bg, fg, { Intensity = 'Normal' }, ' ' .. title)
    _push(bg, fg, { Intensity = 'Normal' }, ' ')
    _push('rgb(51,51,51)', bg, { Intensity = 'Normal' }, GLYPH_SEMI_CIRCLE_RIGHT)
    return __cells__
end)

return {
    --exit_behavior='Hold',
    audible_bell="Disabled",
    window_close_confirmation = "NeverPrompt", --不用确认关闭
    enable_tab_bar = true, --是否隐藏bar
    hide_tab_bar_if_only_one_tab = false,--只有一个tabs是否隐藏
    use_fancy_tab_bar = false,
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",
    enable_scroll_bar = false, --不显示滚动条
    adjust_window_size_when_changing_font_size = false, --控制绘制边框粗细
    initial_rows = 24,
    initial_cols = 80,

    color_scheme = "catppuccin-frappe",
    colors = {
        cursor_bg = "#626880",
        cursor_border = "#626880",
        cursor_fg = "#c6d0f5"

        --foreground = "#c6d0f5",
        --background = "#303446",
        --selection_bg = "#626880",
        --selection_fg = "#c6d0f5",
        --ansi = {"#51576d","#e78284","#a6d189","#e5c890","#8caaee","#f4b8e4","#81c8be","#a5adce"},
        --brights = {"#626880","#e67172","#8ec772","#d9ba73","#7b9ef0","#f2a4db","#5abfb5","#b5bfe2"},
        --split = '#444444',

        --copy_mode_inactive_highlight_bg = { Color = '#626880' },未选中颜色
        --copy_mode_inactive_highlight_fg = { Color = '#ffffff' },

        --copy_mode_active_highlight_bg = { Color = '#ff6a19' },
        --copy_mode_active_highlight_fg = { Color = '#ffffff' }
    },

    integrated_title_button_alignment ="Right",
    integrated_title_button_color = "Auto",
    --integrated_title_button_style = "Windows",
    integrated_title_buttons = { 'Hide', 'Maximize', 'Close' },


    window_padding = { left = 0, right = 0, top = 0, bottom = 0 }, --窗口边距

    window_background_opacity = 0.9, --背景不透明度
    --win32_system_backdrop = 'Acrylic',

    freetype_load_target = "HorizontalLcd", --抗锯齿
    freetype_render_target = "HorizontalLcd",
    front_end = "OpenGL",
    hide_mouse_cursor_when_typing=true,
    custom_block_glyphs = false,



    font = wezterm.font(fonts, { weight = "Regular", stretch = "Normal", style = "Normal" }),
    font_rules = {
        {
            italic = true,
            font = wezterm.font(
            fonts,
            { weight = "Regular", stretch = "Normal", style = "Italic" }
            ),
        },
        {
            intensity = "Bold",
            font = wezterm.font(
            fonts,
            { weight = "Bold", stretch = "Normal", style = "Normal" }
            ),
        },
        {
            intensity = "Bold",
            italic = true,
            font = wezterm.font(
            fonts,
            { weight = "Bold", stretch = "Normal", style = "Italic" }
            ),
        },
    },
    font_size = size,
    keys = {
        { key = 'v', mods = 'ALT', action = wezterm.action.PasteFrom 'Clipboard'},
        { key = 'c', mods = 'ALT', action =  wezterm.action.CopyTo 'Clipboard'},
        { key = 'v', mods = 'SHIFT|CTRL', action = wezterm.action.PasteFrom 'Clipboard'},
        { key = 'c', mods = 'SHIFT|CTRL', action =  wezterm.action.CopyTo 'Clipboard'},


        { key = 'z', mods = 'SHIFT|ALT', action = wezterm.action.DecreaseFontSize },
        { key = 'a', mods = 'SHIFT|ALT', action = wezterm.action.IncreaseFontSize },
        { key = 'r', mods = 'SHIFT|ALT', action = wezterm.action.ResetFontSize },

        { key = 'u', mods = 'SHIFT|ALT', action = wezterm.action.ScrollByLine(-1) },
        { key = 'd', mods = 'SHIFT|ALT', action = wezterm.action.ScrollByLine(1) },
        { key = 'u', mods = 'SHIFT|CTRL', action = wezterm.action.ScrollByPage(-0.5) },
        { key = 'd', mods = 'SHIFT|CTRL', action =wezterm.action.ScrollByPage(0.5) },

        --{ key = 'f', mods = 'ALT',action = act.Search {Regex = '[a-f0-9]{6,}',},},
        --{ key = 'f', mods = 'ALT',action = act.Search { CaseSensitiveString = 'hash' },},
        { key = 'f', mods = 'SHIFT|ALT',action = act.Search { CaseInSensitiveString = '' },},
        { key = 'g', mods = 'SHIFT|ALT', action = wezterm.action.ActivateCopyMode },

        { key = 'w', mods = 'SHIFT|ALT', action = wezterm.action.CloseCurrentTab { confirm = false }, },
        { key = 'x', mods = 'SHIFT|ALT', action = wezterm.action.CloseCurrentPane { confirm = false },},

        { key = 'v', mods = 'SHIFT|ALT',action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },},
        { key = 's', mods = 'SHIFT|ALT',action = wezterm.action.SplitVertical},
        { key = 'm', mods = 'SHIFT|ALT',action = wezterm.action.TogglePaneZoomState,},

        { key = 'o', mods = 'SHIFT|ALT', action = act.SpawnTab 'CurrentPaneDomain',},
        { key = 'p', mods = 'SHIFT|ALT', action = act.ActivateTabRelative(-1) },
        { key = 'n', mods = 'SHIFT|ALT', action = act.ActivateTabRelative(1) },

        { key = 'h', mods = 'SHIFT|ALT',action = act.ActivatePaneDirection 'Left',},
        { key = 'l', mods = 'SHIFT|ALT',action = act.ActivatePaneDirection 'Right',},
        { key = 'k', mods = 'SHIFT|ALT',action = act.ActivatePaneDirection 'Up',},
        { key = 'j', mods = 'SHIFT|ALT',action = act.ActivatePaneDirection 'Down',},

        { key = 'h', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Left', 5 },},
        { key = 'j', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Down', 5 },},
        { key = 'k', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Up', 5 } },
        { key = 'l', mods = 'SHIFT|CTRL', action = act.AdjustPaneSize { 'Right', 5 },},
        { key = 'p', mods = 'SHIFT|CTRL', action = wezterm.action.ShowLauncherArgs{flags='LAUNCH_MENU_ITEMS'}},
        --{ key = 's', mods = 'ALT', action = act.SendString '\u003A\u0077\u0071\u000D' },

        {
            key = 'x',
            mods = 'SHIFT|ALT',
            action = wezterm.action_callback(function(win, pane)
                local tab = win:active_tab()
                for i = #tab:panes(), 1, -1 do -- 反向遍历避免动态修改问题
                    local p = tab:panes()[i]
                    if p:pane_id() ~= pane:pane_id() then
                        p:activate()
                        win:perform_action(wezterm.action.CloseCurrentPane{confirm = false}, p)
                    end
                end
            end),
        },

        {
            key = "q",
            mods = "SHIFT|ALT",
            action = wezterm.action_callback(function(win, _)
                local current_tab = win:active_tab()
                for _, tab in ipairs(win:mux_window():tabs()) do
                    if tab:tab_id() ~= current_tab:tab_id() then
                        tab:activate()
                        local panes = tab:panes()
                        if #panes > 0 then
                            for i = #panes, 1, -1 do
                                win:perform_action(
                                    wezterm.action.CloseCurrentPane({ confirm = false }),
                                    panes[i]
                                )
                            end
                        else
                            win:perform_action(
                                wezterm.action.CloseCurrentTab({ confirm = false }),
                                tab:active_pane() or win:active_pane()
                            )
                        end
                    end
                end
            end),
        },
    }

    --default_prog = { 'nu.exe' },
    --default_cwd = "D:/",
        --launch_menu = {
        --{ label = 'nushell', args = { 'nu.exe' }, },
        --{ label = 'Powershell', args = { 'powershell.exe' }, },
        --{ label='Mingw64',args={ msys, '-defterm', '-here', '-no-start', '-mingw64'},},
        --{ label='ucrt64',args={ msys, '-defterm', '-here', '-no-start', '-ucrt64'},},
        --{ label='Wsl',args={'wsl'},},
        --{ label='Tmux',args={'wsl.exe','--cd','~','--exec','tmux'},},
    --},
}

--[[ {
    key = 'q',
    mods = 'SHIFT|ALT',
    action = wezterm.action_callback(function(win, pane)
        local current_tab = win:active_tab()

        for _, tab in ipairs(win:mux_window():tabs()) do
            if tab:tab_id() ~= current_tab:tab_id() then
                tab:activate()
                win:perform_action(wezterm.action.CloseCurrentTab({ confirm = false }), pane)
            end
        end

    end),
}, ]]
