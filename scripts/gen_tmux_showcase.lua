-- Generates an SVG mock of a tmux-powerline status bar for a lazypunk variant,
-- using the variant's palette. Curated segments (no live/private data).
-- Powerline separators are drawn as polygons (Nerd glyphs don't render in SVG).
-- Usage: nvim --headless -l scripts/gen_tmux_showcase.lua <variant> <out.svg>
local variant = arg[1]
local out = arg[2]

vim.opt.runtimepath:prepend(vim.fn.getcwd())
local p = require('lazypunk.palettes.' .. variant)

local H, CW, FS = 40, 8.4, 15
local SLANT = 12
local bar_bg = p.bg_dark

-- {text, bg, fg, bold}
local left = {
  { 'lazypunk',   p.accent2, p.bg_dark, true },
  { 'edgerunner', p.func,    p.bg_dark },
  { ' main',     p.keyword, p.bg_dark },
}
-- window tabs sit on the bar background (current highlighted)
local windows = {
  { '1 nvim', p.accent,   p.bg_dark, true },
  { '2 fish', p.bg_float, p.comment },
  { '3 logs', p.bg_float, p.comment },
}
local right = {
  { '0.42',   p.bg_float, p.number },
  { '87%',   p.warn,     p.bg_dark },
  { 'Sat 12', p.border,   p.fg },
  { '21:00',  p.border,   p.fg },
}

local function textw(s) return #s * CW end
local parts = {}
local function push(s) parts[#parts + 1] = s end

local function seg_rect(x, w, bg) return string.format('<rect x="%.1f" y="0" width="%.1f" height="%d" fill="%s"/>', x, w, H, bg) end
local function seg_text(x, s, fg, bold)
  local b = bold and ' font-weight="bold"' or ''
  return string.format('<text x="%.1f" y="%.1f" fill="%s"%s xml:space="preserve">%s</text>', x, H / 2 + FS * 0.35, fg, b, s)
end
-- right-pointing arrow of color `c` starting at seam x (juts right into next area)
local function arrow_r(x, c) return string.format('<polygon points="%.1f,0 %.1f,%d %.1f,%d" fill="%s"/>', x, x + SLANT, H / 2, x, H, c) end
-- left-pointing arrow of color `c` with tip at x (juts left)
local function arrow_l(x, c) return string.format('<polygon points="%.1f,0 %.1f,%d %.1f,%d" fill="%s"/>', x, x - SLANT, H / 2, x, H, c) end

-- total width estimate
local total = 0
for _, s in ipairs(left) do total = total + textw(s[1]) + 20 + SLANT end
for _, s in ipairs(windows) do total = total + textw(s[1]) + 18 end
total = total + 40
for _, s in ipairs(right) do total = total + textw(s[1]) + 18 + SLANT end
local W = math.floor(total + 20)

-- Three layers so seams never clip: rects, then arrows, then text on top.
local rects, arrows, texts = {}, {}, {}
local function R(s) rects[#rects + 1] = s end
local function A(s) arrows[#arrows + 1] = s end
local function T(s) texts[#texts + 1] = s end

-- LEFT cluster (arrows point right)
local x = 0
for _, s in ipairs(left) do
  local w = textw(s[1]) + 16 + SLANT
  R(seg_rect(x, w, s[2]))
  A(arrow_r(x + w, s[2]))
  T(seg_text(x + 10, s[1], s[3], s[4]))
  x = x + w
end
local wx = x + SLANT + 8
for _, s in ipairs(windows) do
  local w = textw(s[1]) + 14
  if s[2] ~= bar_bg then R(seg_rect(wx, w, s[2])) end
  T(seg_text(wx + 7, s[1], s[3], s[4]))
  wx = wx + w + 6
end

-- RIGHT cluster (arrows point left), laid out from the right edge
local rx = W
for i = #right, 1, -1 do
  local s = right[i]
  local w = textw(s[1]) + 16 + SLANT
  local x0 = rx - w
  R(seg_rect(x0, w, s[2]))
  A(arrow_l(x0, s[2]))
  T(seg_text(x0 + SLANT + 6, s[1], s[3], s[4]))
  rx = x0
end

push(string.format('<svg xmlns="http://www.w3.org/2000/svg" width="%d" height="%d" viewBox="0 0 %d %d" font-family="ui-monospace, SFMono-Regular, Menlo, Consolas, monospace" font-size="%d">', W, H, W, H, FS))
push(string.format('<rect x="0" y="0" width="%d" height="%d" rx="6" fill="%s"/>', W, H, bar_bg))
for _, s in ipairs(rects) do push(s) end
for _, s in ipairs(arrows) do push(s) end
for _, s in ipairs(texts) do push(s) end
push('</svg>')

local f = io.open(out, 'w')
f:write(table.concat(parts, '\n'))
f:close()
print('wrote ' .. out)
