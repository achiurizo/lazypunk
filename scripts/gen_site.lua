-- Serializes every lazypunk palette to a single JSON consumed by the Vite/Svelte
-- site build. Mirrors the discovery/require pattern of scripts/gen_readme.lua.
-- Usage: nvim --headless -l scripts/gen_site.lua [site/src/lib/palettes.json]
local out = arg[1] or 'site/src/lib/palettes.json'
local palette_dir = 'lua/lazypunk/palettes'

vim.opt.runtimepath:prepend(vim.fn.getcwd())

local REQUIRED = {
  'bg','bg_dark','bg_float','cursorline','bg_sel','border','gutter',
  'fg','fg_dim','comment',
  'keyword','func','string','number','constant','type','property','operator',
  'variable','parameter','preproc',
  'error','warn','info','hint','ok',
  'git_add','git_change','git_delete',
  'accent','accent2',
}

local order_pref = { 'lucy', 'david', 'rebecca', 'sasha' }

-- Discover variants.
local present = {}
for _, f in ipairs(vim.fn.glob(palette_dir .. '/*.lua', false, true)) do
  present[vim.fn.fnamemodify(f, ':t:r')] = true
end

-- Build ordered list: preferred first, then any others alphabetically.
local order, seen = {}, {}
for _, v in ipairs(order_pref) do
  if present[v] then order[#order + 1] = v; seen[v] = true end
end
local rest = {}
for v in pairs(present) do if not seen[v] then rest[#rest + 1] = v end end
table.sort(rest)
for _, v in ipairs(rest) do order[#order + 1] = v end

-- Read the blurb from a palette file's first-line comment:
--   "-- lazypunk-lucy — cool indigo night; ..." -> "cool indigo night; ..."
local function read_blurb(variant)
  local fh = io.open(palette_dir .. '/' .. variant .. '.lua', 'r')
  if not fh then return '' end
  local first = fh:read('*l') or ''
  fh:close()
  local prefix = '^%s*%-%-%s*lazypunk%-' .. variant .. '%s*'
  -- The class [—-] is byte-oriented and only matches the em dash's first byte,
  -- corrupting the capture with dangling UTF-8 continuation bytes; match the
  -- 3-byte em dash (U+2014) literally, falling back to a plain hyphen.
  local blurb = first:match(prefix .. '\226\128\148%s*(.-)%s*%.?$')
    or first:match(prefix .. '%-%s*(.-)%s*%.?$')
  return blurb or ''
end

local variants = {}
for _, v in ipairs(order) do
  local p = require('lazypunk.palettes.' .. v)
  local roles = {}
  for _, key in ipairs(REQUIRED) do
    local val = p[key]
    if type(val) ~= 'string' then
      error(string.format('palette %q missing string role %q', v, key))
    end
    roles[key] = val
  end
  if type(p.ansi) ~= 'table' or #p.ansi ~= 16 then
    error(string.format('palette %q must have ansi array of length 16', v))
  end
  variants[v] = { name = v, blurb = read_blurb(v), roles = roles, ansi = p.ansi }
end

local doc = { order = order, variants = variants }

-- Ensure output directory exists, then write pretty-ish JSON.
vim.fn.mkdir(vim.fn.fnamemodify(out, ':h'), 'p')
local json = vim.fn.json_encode(doc)
local fh = assert(io.open(out, 'w'))
fh:write(json)
fh:write('\n')
fh:close()
print('wrote ' .. out .. ' (' .. #order .. ' variants)')
