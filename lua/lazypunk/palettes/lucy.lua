-- lazypunk-lucy — cool indigo night, neon violet/blue/magenta.
-- Derived from the Edgerunners "Lucy" key art: deep indigo-black grounds,
-- electric-blue functions, mint strings, magenta constants, hot-rose errors.
-- One synthetic accent: amber `warn`, absent from the art, added so warnings
-- stay legible against errors.
return {
  -- backgrounds (dark → light)
  bg         = "#0f0d1e",
  bg_dark    = "#0a0814", -- gutter/inactive backdrop
  bg_float   = "#14122a",
  cursorline = "#1a1733",
  bg_sel     = "#2a2450", -- visual selection
  border     = "#3a3560",
  gutter     = "#4a4570",

  -- foregrounds
  fg      = "#e7dcf0",
  fg_dim  = "#b1aaef",
  comment = "#6f6a9c",

  -- syntax roles
  keyword   = "#9d7cff", -- violet
  func      = "#5b8cff", -- electric blue
  string    = "#7ef0d0", -- mint (hair streak / eye cyan)
  number    = "#c264e0", -- magenta (city lights)
  constant  = "#c264e0",
  type      = "#f0a6dd", -- soft pink
  property  = "#b1aaef", -- lilac
  operator  = "#8a84c0", -- dim violet
  variable  = "#e7dcf0",
  parameter = "#d6cdf5",
  preproc   = "#c264e0",

  -- diagnostics
  error = "#ff5d8f", -- hot rose
  warn  = "#ffc14d", -- synthetic amber (see header)
  info  = "#5b8cff",
  hint  = "#7ef0d0",
  ok    = "#7ef0d0",

  -- git
  git_add    = "#7ef0d0",
  git_change = "#9d7cff",
  git_delete = "#ff5d8f",

  -- ui accents
  accent  = "#c264e0",
  accent2 = "#5b8cff",

  -- terminal ANSI 0..15
  ansi = {
    "#1a1733", "#ff5d8f", "#7ef0d0", "#ffc14d",
    "#5b8cff", "#c264e0", "#5bd6ff", "#b1aaef",
    "#3a3560", "#ff87ab", "#9ff5dd", "#ffd27a",
    "#84a9ff", "#d68cf0", "#8ee4ff", "#e7dcf0",
  },
}
