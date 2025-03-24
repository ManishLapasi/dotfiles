-- Initialize Configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local opacity = 1
local transparent_bg = "rgba(22, 24, 26, " .. opacity .. ")"

--- Get the current operating system
--- @return "windows"| "linux" | "macos"
local function get_os()
    local bin_format = package.cpath:match("%p[\\|/]?%p(%a+)")
    if bin_format == "dll" then
        return "windows"
    elseif bin_format == "so" then
        return "linux"
    end

    return "macos"
end

local host_os = get_os()

-- Color Configuration
config.colors = require("cyberdream")
config.force_reverse_video_cursor = true

-- Font configuration
config.font_dirs = { 'C:\\Users\\manis\\AppData\\Local\\fonts' }
config.font = wezterm.font_with_fallback({
    {
        family = "CaskaydiaCove Nerd Font",
        weight = "Regular",
    }
})
config.font_size = 10

-- Window Configuration
config.initial_rows = 35
config.initial_cols = 180
config.window_decorations = "RESIZE"
config.window_background_opacity = opacity
config.window_background_image = (os.getenv("WEZTERM_CONFIG_FILE") or ""):gsub("wezterm.lua", "bg-blurred.png")
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

-- Tab Bar Configuration
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.colors.tab_bar = {
    background = config.window_background_image and "rgba(0, 0, 0, 0)" or transparent_bg,
    new_tab = { fg_color = config.colors.background, bg_color = config.colors.brights[6] },
    new_tab_hover = { fg_color = config.colors.background, bg_color = config.colors.foreground },
}

-- Tab Formatting
wezterm.on("format-tab-title", function(tab, _, _, _, hover)
    local background = config.colors.brights[1]
    local foreground = config.colors.foreground

    if tab.is_active then
        background = config.colors.brights[7]
        foreground = config.colors.background
    elseif hover then
        background = config.colors.brights[8]
        foreground = config.colors.background
    end

    local title = tostring(tab.tab_index + 1)
    return {
        { Foreground = { Color = background } },
        { Text = "█" },
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = title },
        { Foreground = { Color = background } },
        { Text = "█" },
    }
end)

-- CmdLine
config.status_update_interval = 1000
wezterm.on("update-status", function(window, pane)
	local basename = function(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			cwd = basename(cwd.file_path)
		else
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Current command
	local cmd = pane:get_foreground_process_name()
	cmd = cmd and basename(cmd) or ""

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Right status
	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)


-- Keybindings
config.keys = {
    { key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
    { key = "F11", action = wezterm.action.ToggleFullScreen },
    { key = "r", mods = "CTRL", action = wezterm.action.ReloadConfiguration },
    { key = "1", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "2", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
}

-- OS-Specific Overrides
if host_os == "linux" then
    emoji_font = "Noto Color Emoji"
    config.default_prog = { "zsh" }
    config.front_end = "WebGpu"
    config.window_background_image = os.getenv("HOME") .. "/.config/wezterm/bg-blurred.png"
    config.window_decorations = nil -- use system decorations
end

return config
