-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- config.front_end = "WebGpu"
-- config.webgpu_power_preference = "HighPerformance"

--
config.font_size = 28
config.line_height = 0.9
config.bold_brightens_ansi_colors = true
config.use_cap_height_to_scale_fallback_fonts = true

config.hyperlink_rules = {
	-- Linkify things that look like URLs and the host has a TLD name.
	--
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},

	-- linkify email addresses
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
		format = "mailto:$0",
	},

	-- file:// URI
	-- Compiled-in default. Used if you don't specify any hyperlink_rules.
	{
		regex = [[\bfile://\S*\b]],
		format = "$0",
	},

	-- Linkify things that look like URLs with numeric addresses as hosts.
	-- E.g. http://127.0.0.1:8000 for a local development server,
	-- or http://192.168.1.1 for the web interface of many routers.
	{
		regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
		format = "$0",
	},

	-- Make username/project paths clickable. This implies paths like the following are for GitHub.
	-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
	-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
	{
		regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
		format = "https://www.github.com/$1/$3",
	},
}

config.font = wezterm.font_with_fallback({
	"Maple Mono NF CN",
	"FiraCode Nerd Font",
	"Noto Color Emoji",
	"Symbols Nerd Font Mono",
})

config.font_rules = {
	{
		intensity = "Normal",
		italic = false,
		font = wezterm.font({
			family = "Maple Mono NF CN",
			weight = "Regular",
			harfbuzz_features = {
				"liga",
				"calt",
				"dlig",
				"zero",
				"cv01",
				"cv05",
				"cv08",
				"cv09",
				"cv10",
				"cv29",
				"cv31",
				"cv32",
				"cv37",
				"cv38",
				"cv43",
				"cv64",
			},
		}),
	},
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = "Maple Mono NF CN",
			weight = "ExtraBold",
			harfbuzz_features = {
				"liga",
				"calt",
				"dlig",
				"zero",
				"cv01",
				"cv05",
				"cv08",
				"cv09",
				"cv10",
				"cv29",
				"cv31",
				"cv32",
				"cv37",
				"cv38",
				"cv43",
				"cv64",
			},
		}),
	},
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = "Maple Mono NF CN",
			weight = "Regular",
			style = "Italic",
			harfbuzz_features = {
				"liga",
				"calt",
				"dlig",
				"zero",
				"cv01",
				"cv05",
				"cv09",
				"cv10",
				"cv29",
				"cv31",
				"cv32",
				"cv37",
				"cv38",
				"cv43",
				"cv64",
			},
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = "Maple Mono NF CN",
			weight = "ExtraBold",
			style = "Italic",
			harfbuzz_features = {
				"liga",
				"calt",
				"dlig",
				"zero",
				"cv01",
				"cv05",
				"cv09",
				"cv10",
				"cv29",
				"cv31",
				"cv32",
				"cv37",
				"cv38",
				"cv43",
				"cv64",
			},
		}),
	},
}
config.use_fancy_tab_bar = false
config.enable_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = true
config.native_macos_fullscreen_mode = true
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.97
-- config.macos_window_background_blur = 30
config.force_reverse_video_cursor = true

config.window_padding = {
	top = 0,
	bottom = 0,
	left = 0,
	right = 0,
}

config.default_cursor_style = "BlinkingBar"
config.color_scheme = "Oasis Desert Dark"

return config
