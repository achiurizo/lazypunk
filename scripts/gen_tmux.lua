-- Generates a tmux-powerline theme for a lazypunk variant from its palette.
-- Same segment layout as a stock catppuccin-mocha theme; recolored with the
-- variant's exact hex (tmux-powerline passes non-numeric colors through
-- unchanged, so truecolor hex renders as-is).
-- Usage: nvim --headless -l scripts/gen_tmux.lua <variant> <out.sh>
local variant = arg[1]
local out = arg[2]

vim.opt.runtimepath:prepend(vim.fn.getcwd())
local p = require('lazypunk.palettes.' .. variant)

-- Role -> palette key mapping for the powerline segments.
local sub = {
  variant   = variant,
  bg        = p.bg_dark,   -- status bar background
  fg        = p.fg,        -- default text
  fg_dim    = p.fg_dim,
  surface   = p.bg_float,  -- neutral segment fill
  neutral   = p.border,    -- date/time fill
  dark      = p.bg_dark,   -- text on bright segments
  session   = p.string,    -- session (mint/teal)
  host      = p.func,      -- hostname (blue)
  branch    = p.keyword,   -- vcs branch (violet)
  focus     = p.keyword,
  agents    = p.accent2,
  alert     = p.error,
  path      = p.string,
  load      = p.number,
  battery   = p.warn,
}

local template = [[
# shellcheck shell=bash
# lazypunk-{{variant}} theme for tmux-powerline
# Generated from lua/lazypunk/palettes/{{variant}}.lua by scripts/gen_tmux.lua.
# tmux-powerline passes non-numeric colors through unchanged, so these hex
# values render directly under a truecolor terminal.

if tp_patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'{{bg}}'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'{{fg}}'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_CURRENT" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#[$(tp_format inverse)]"
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
		" #I#F "
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN"
		" #W "
		"#[$(tp_format regular)]"
		"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR"
	)
fi

# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_STYLE" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(tp_format regular)"
	)
fi

# shellcheck disable=SC2128
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_FORMAT" ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#[$(tp_format regular)]"
		"  #I#{?window_flags,#F, } "
		"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN"
		" #W "
	)
fi

# Segment format: name bg fg [separator] [sep_bg] [sep_fg] [spacing] [sep_disable]

# shellcheck disable=SC1143,SC2128
if [ -z "$TMUX_POWERLINE_LEFT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"tmux_session_info {{session}} {{dark}}"
		"hostname {{host}} {{dark}}"
		"lan_ip {{surface}} {{fg}} ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}"
		"wan_ip {{surface}} {{fg}}"
		"vcs_branch {{branch}} {{dark}}"
	)
fi

# shellcheck disable=SC1143,SC2128
if [ -z "$TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		"focus_mode {{focus}} {{dark}}"
		"claude_agents {{agents}} {{dark}}"
		"claude_agents_alert {{alert}} {{dark}}"
		"pwd {{path}} {{dark}}"
		"load {{surface}} {{load}}"
		"battery {{battery}} {{dark}}"
		"date_day {{neutral}} {{fg}}"
		"date {{neutral}} {{fg}} ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}"
		"time {{neutral}} {{fg}} ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}"
	)
fi
]]

local outstr = template:gsub('{{(%w+)}}', function(k)
  local v = sub[k]
  if v == nil then error('unmapped placeholder: ' .. k) end
  return v
end)

local f = io.open(out, 'w')
f:write(outstr)
f:close()
print('wrote ' .. out)
