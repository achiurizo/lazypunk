-- lazypunk-david — warm gritty night; signature electric yellow + teal.
-- Derived from the Edgerunners crew key art on David's hot-yellow ground:
-- near-black warm grounds, yellow keywords (his identity), teal functions,
-- olive-green strings, coral constants, blood-red errors. Yellow is native
-- to the art, so warnings need no synthetic accent.
return {
  -- backgrounds (dark → light)
  bg         = "#0b0c09",
  bg_dark    = "#070805",
  bg_float   = "#121410",
  cursorline = "#181a14",
  bg_sel     = "#2b2f21", -- olive-tinted selection
  border     = "#33372a",
  gutter     = "#565a45",

  -- foregrounds
  fg      = "#e6e8e0",
  fg_dim  = "#a7a99b",
  comment = "#6b6f5e",

  -- syntax roles
  keyword   = "#eddd3c", -- electric yellow (signature)
  func      = "#5fc9c2", -- teal
  string    = "#93c46f", -- olive green
  number    = "#ff8663", -- coral
  constant  = "#ff8663",
  type      = "#d7c074", -- warm gold
  property  = "#9aa4c0", -- steel blue-grey
  operator  = "#8b8e73", -- muted olive
  variable  = "#e6e8e0",
  parameter = "#cdd0be",
  preproc   = "#ff8663",

  -- diagnostics
  error = "#ff5a4d", -- blood red
  warn  = "#f7ef2e", -- bright yellow (native)
  info  = "#5fc9c2",
  hint  = "#93c46f",
  ok    = "#93c46f",

  -- git
  git_add    = "#93c46f",
  git_change = "#5fc9c2",
  git_delete = "#ff5a4d",

  -- ui accents
  accent  = "#eddd3c",
  accent2 = "#5fc9c2",

  -- terminal ANSI 0..15
  ansi = {
    "#181a14", "#ff5a4d", "#93c46f", "#eddd3c",
    "#5fc9c2", "#ff8663", "#5fc9c2", "#a7a99b",
    "#33372a", "#ff7a6b", "#a9d488", "#f7ef2e",
    "#7fd8d1", "#ff9b7d", "#7fd8d1", "#e6e8e0",
  },
}
