-- lazypunk-rebecca — murky teal-green night, hot pink + mint + amber.
-- Derived from the Edgerunners "Rebecca" key art: dark green-black grounds,
-- hot-pink keywords (her chaotic energy), teal functions, mint-green strings,
-- amber constants (her iconic glowing eyes), rose-red errors. Amber is native
-- to the art, so warnings need no synthetic accent.
return {
  -- backgrounds (dark → light)
  bg         = "#0d1512",
  bg_dark    = "#070d0a",
  bg_float   = "#131c17",
  cursorline = "#17211b",
  bg_sel     = "#234032", -- teal-green selection
  border     = "#2c4438",
  gutter     = "#4a6355",

  -- foregrounds
  fg      = "#d5e4d8",
  fg_dim  = "#8ba699",
  comment = "#5f7568",

  -- syntax roles
  keyword   = "#ff6e9c", -- hot pink (signature)
  func      = "#57c4bb", -- teal
  string    = "#8fd694", -- mint green (hair)
  number    = "#ff9e48", -- amber (her eyes)
  constant  = "#ff9e48",
  type      = "#eaa6c6", -- soft pink
  property  = "#a9c4b3", -- mint grey
  operator  = "#6f8779", -- muted green
  variable  = "#d5e4d8",
  parameter = "#c3d8c8",
  preproc   = "#ff9e48",

  -- diagnostics
  error = "#ff5d7a", -- rose red
  warn  = "#ffc24a", -- amber (native)
  info  = "#57c4bb",
  hint  = "#8fd694",
  ok    = "#8fd694",

  -- git
  git_add    = "#8fd694",
  git_change = "#57c4bb",
  git_delete = "#ff5d7a",

  -- ui accents
  accent  = "#ff6e9c",
  accent2 = "#57c4bb",

  -- terminal ANSI 0..15
  ansi = {
    "#17211b", "#ff5d7a", "#8fd694", "#ffc24a",
    "#57c4bb", "#ff6e9c", "#6dd0c0", "#a9c4b3",
    "#2c4438", "#ff86a0", "#a9e2ac", "#ffcf6e",
    "#7ad6cd", "#ff92b6", "#8fe0d5", "#d5e4d8",
  },
}
