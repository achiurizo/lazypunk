-- lazypunk-sasha — violet-black ground, periwinkle and pink neon, mint strings.
-- Violet keywords, periwinkle functions, mint strings, hot-pink constants and a
-- pink-magenta accent. One synthetic accent: amber `warn`, kept so warnings
-- stay legible against errors.
return {
  -- backgrounds (dark → light)
  bg         = "#110b20",
  bg_dark    = "#0b0716", -- gutter/inactive backdrop
  bg_float   = "#17102c",
  cursorline = "#1d1536",
  bg_sel     = "#33225c", -- visual selection
  border     = "#40306b",
  gutter     = "#54437f",

  -- foregrounds
  fg      = "#ebdff5",
  fg_dim  = "#bda9f2",
  comment = "#766a9f",

  -- syntax roles
  keyword   = "#b388ff", -- violet
  func      = "#8d9bff", -- periwinkle
  string    = "#7ef0d0", -- mint
  number    = "#ff6ad5", -- hot pink
  constant  = "#ff6ad5",
  type      = "#f0a6dd", -- soft pink
  property  = "#bda9f2", -- lilac
  operator  = "#9484c9", -- dim violet
  variable  = "#ebdff5",
  parameter = "#dacdf7",
  preproc   = "#ff6ad5",

  -- diagnostics
  error = "#ff5370", -- neon red
  warn  = "#ffc14d", -- synthetic amber (see header)
  info  = "#8d9bff",
  hint  = "#7ef0d0",
  ok    = "#7ef0d0",

  -- git
  git_add    = "#7ef0d0",
  git_change = "#b388ff",
  git_delete = "#ff5370",

  -- ui accents
  accent  = "#e058f5",
  accent2 = "#8d9bff",

  -- terminal ANSI 0..15
  ansi = {
    "#1d1536", "#ff5370", "#7ef0d0", "#ffc14d",
    "#8d9bff", "#e058f5", "#7fd4ff", "#bda9f2",
    "#40306b", "#ff7d93", "#9ff5dd", "#ffd27a",
    "#aab4ff", "#ec8cf8", "#a8e2ff", "#ebdff5",
  },
}
