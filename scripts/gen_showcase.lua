-- Generates an SVG "editor pane" showcase for a lazypunk variant using the
-- theme's ACTUAL resolved highlight colors (synID -> synIDtrans -> synIDattr).
-- Usage: nvim --headless -l gen_showcase.lua <variant> <out.svg>
local variant = arg[1]
local out = arg[2]

-- `-l` runs a minimal nvim; put the repo (cwd) on runtimepath so colors/ + lua/ resolve.
vim.opt.runtimepath:prepend(vim.fn.getcwd())
vim.o.termguicolors = true

-- Sample buffer: rich token variety (comments, keywords, strings, numbers, fns).
local sample = {
  '-- lazypunk: palette-driven colorscheme',
  'local M = {}',
  '',
  'local palettes = { "lucy", "david", "rebecca" }',
  '',
  'function M.load(name)',
  '  name = name or "lucy"',
  '  local ok = pcall(require, "lazypunk")',
  '  if not ok then',
  '    return vim.notify("lazypunk: unknown variant", 3)',
  '  end',
  '',
  '  vim.g.colors_name = "lazypunk-" .. name',
  '  return true',
  'end',
  '',
  'return M',
}

-- Load buffer + syntax + colorscheme.
vim.api.nvim_buf_set_lines(0, 0, -1, false, sample)
vim.bo.filetype = 'lua'
vim.cmd('syntax on')
vim.cmd('colorscheme lazypunk-' .. variant)

local function hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end
local function hex(n) return n and string.format('#%06x', n) or nil end

local normal = hl('Normal')
local bg = hex(normal.bg) or '#101010'
local fg = hex(normal.fg) or '#e0e0e0'
local linenr = hex(hl('LineNr').fg) or fg
local curnr = hex((hl('CursorLineNr').fg)) or fg
local statusline = hl('StatusLine')
local sl_bg = hex(statusline.bg) or bg
local sl_fg = hex(statusline.fg) or fg
local accent = hex((hl('Function').fg)) or fg

-- Per-character color via the syntax engine (authentic to the theme).
local function char_color(line, col)
  local id = vim.fn.synID(line, col, 1)
  local trans = vim.fn.synIDtrans(id)
  local c = vim.fn.synIDattr(trans, 'fg#')
  if c == nil or c == '' then return fg, false, false end
  local bold = vim.fn.synIDattr(trans, 'bold') == '1'
  local italic = vim.fn.synIDattr(trans, 'italic') == '1'
  return c, bold, italic
end

local function xml_escape(s)
  return (s:gsub('&', '&amp;'):gsub('<', '&lt;'):gsub('>', '&gt;'))
end

-- Layout.
local CW, LH = 8.4, 20        -- char width, line height
local FS = 14                 -- font size
local PAD_X = 16
local TITLE_H = 34
local GUTTER = 3 * CW + 10    -- room for 2-digit line numbers + pad
local text_x0 = PAD_X + GUTTER
local n = #sample
local maxlen = 0
for _, l in ipairs(sample) do maxlen = math.max(maxlen, #l) end
local W = math.floor(text_x0 + maxlen * CW + PAD_X + 0.5)
local body_h = n * LH + 12
local STATUS_H = 24
local H = TITLE_H + body_h + STATUS_H

local svg = {}
local function push(s) svg[#svg + 1] = s end

push(string.format('<svg xmlns="http://www.w3.org/2000/svg" width="%d" height="%d" viewBox="0 0 %d %d" font-family="ui-monospace, SFMono-Regular, Menlo, Consolas, monospace" font-size="%d">', W, H, W, H, FS))
-- window background + rounded corners
push(string.format('<rect x="0" y="0" width="%d" height="%d" rx="10" fill="%s"/>', W, H, bg))
-- title bar
push(string.format('<rect x="0" y="0" width="%d" height="%d" rx="10" fill="%s"/>', W, TITLE_H, sl_bg))
push(string.format('<rect x="0" y="%d" width="%d" height="12" fill="%s"/>', TITLE_H - 12, W, sl_bg))
-- traffic lights
push(string.format('<circle cx="18" cy="%d" r="6" fill="#ff5f57"/>', TITLE_H / 2))
push(string.format('<circle cx="38" cy="%d" r="6" fill="#febc2e"/>', TITLE_H / 2))
push(string.format('<circle cx="58" cy="%d" r="6" fill="#28c840"/>', TITLE_H / 2))
-- title text
push(string.format('<text x="%d" y="%d" fill="%s" opacity="0.85" text-anchor="middle">lazypunk-%s.lua</text>', W / 2, TITLE_H / 2 + 5, sl_fg, variant))

-- body lines
local y0 = TITLE_H + FS + 4
for i, line in ipairs(sample) do
  local ly = y0 + (i - 1) * LH
  -- line number gutter
  push(string.format('<text x="%d" y="%.1f" fill="%s" text-anchor="end" opacity="0.9">%d</text>', text_x0 - 10, ly, linenr, i))
  -- runs of same color
  local col = 1
  local len = #line
  while col <= len do
    local c0, b0, it0 = char_color(i, col)
    local j = col
    local run = {}
    while j <= len do
      local cj, bj, itj = char_color(i, j)
      if cj ~= c0 or bj ~= b0 or itj ~= it0 then break end
      run[#run + 1] = line:sub(j, j)
      j = j + 1
    end
    local text = xml_escape(table.concat(run))
    -- preserve leading spaces exactly via xml:space
    local x = text_x0 + (col - 1) * CW
    local attrs = string.format('x="%.1f" y="%.1f" fill="%s"', x, ly, c0)
    if b0 then attrs = attrs .. ' font-weight="bold"' end
    if it0 then attrs = attrs .. ' font-style="italic"' end
    push(string.format('<text %s xml:space="preserve">%s</text>', attrs, text))
    col = j
  end
end

-- statusline
local sy = TITLE_H + body_h
push(string.format('<rect x="0" y="%d" width="%d" height="%d" fill="%s"/>', sy, W, STATUS_H, sl_bg))
push(string.format('<rect x="0" y="%d" width="70" height="%d" fill="%s"/>', sy, STATUS_H, accent))
push(string.format('<text x="14" y="%d" fill="%s" font-weight="bold">NORMAL</text>', sy + 16, bg))
push(string.format('<text x="84" y="%d" fill="%s" opacity="0.9">lazypunk-%s</text>', sy + 16, sl_fg, variant))
push(string.format('<text x="%d" y="%d" fill="%s" opacity="0.9" text-anchor="end">lua utf-8  17:1</text>', W - 14, sy + 16, sl_fg))

push('</svg>')

local f = io.open(out, 'w')
f:write(table.concat(svg, '\n'))
f:close()
print('wrote ' .. out)
