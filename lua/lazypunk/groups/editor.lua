-- Core editor UI: base surfaces, gutters, floats, menus, search, diffs, messages.
return function(p)
  return {
    Normal       = { fg = p.fg, bg = p.bg },
    NormalNC     = { fg = p.fg, bg = p.bg },
    NormalFloat  = { fg = p.fg, bg = p.bg_float },
    FloatBorder  = { fg = p.border, bg = p.bg_float },
    FloatTitle   = { fg = p.accent, bg = p.bg_float, bold = true },
    ColorColumn  = { bg = p.bg_float },
    Conceal      = { fg = p.comment },
    Cursor       = { fg = p.bg, bg = p.fg },
    lCursor      = { fg = p.bg, bg = p.fg },
    CursorIM     = { fg = p.bg, bg = p.fg },
    CursorLine   = { bg = p.cursorline },
    CursorColumn = { bg = p.cursorline },
    CursorLineNr = { fg = p.accent, bold = true },
    LineNr       = { fg = p.gutter },
    LineNrAbove  = { fg = p.gutter },
    LineNrBelow  = { fg = p.gutter },
    SignColumn   = { fg = p.gutter, bg = p.bg },
    FoldColumn   = { fg = p.gutter, bg = p.bg },
    Folded       = { fg = p.fg_dim, bg = p.bg_float },

    WinSeparator = { fg = p.border },
    VertSplit    = { fg = p.border },

    Visual       = { bg = p.bg_sel },
    VisualNOS    = { bg = p.bg_sel },

    Search       = { fg = p.bg, bg = p.accent2 },
    IncSearch    = { fg = p.bg, bg = p.accent, bold = true },
    CurSearch    = { fg = p.bg, bg = p.accent, bold = true },
    Substitute   = { fg = p.bg, bg = p.error },
    MatchParen   = { fg = p.accent, bold = true, underline = true },

    Pmenu        = { fg = p.fg, bg = p.bg_float },
    PmenuSel     = { fg = p.bg, bg = p.accent, bold = true },
    PmenuKind    = { fg = p.type, bg = p.bg_float },
    PmenuKindSel = { fg = p.bg, bg = p.accent },
    PmenuExtra   = { fg = p.comment, bg = p.bg_float },
    PmenuExtraSel = { fg = p.bg, bg = p.accent },
    PmenuSbar    = { bg = p.bg_float },
    PmenuThumb   = { bg = p.border },
    WildMenu     = { fg = p.bg, bg = p.accent },

    StatusLine   = { fg = p.fg, bg = p.bg_float },
    StatusLineNC = { fg = p.comment, bg = p.bg_dark },
    TabLine      = { fg = p.comment, bg = p.bg_dark },
    TabLineFill  = { bg = p.bg_dark },
    TabLineSel   = { fg = p.bg, bg = p.accent, bold = true },
    WinBar       = { fg = p.fg_dim, bg = p.bg },
    WinBarNC     = { fg = p.comment, bg = p.bg },

    Title     = { fg = p.accent, bold = true },
    Directory = { fg = p.func },
    QuickFixLine = { bg = p.bg_sel, bold = true },

    NonText      = { fg = p.gutter },
    SpecialKey   = { fg = p.gutter },
    Whitespace   = { fg = p.gutter },
    EndOfBuffer  = { fg = p.bg },

    ErrorMsg   = { fg = p.error, bold = true },
    WarningMsg = { fg = p.warn },
    ModeMsg    = { fg = p.fg_dim, bold = true },
    MoreMsg    = { fg = p.info },
    MsgArea    = { fg = p.fg },
    Question   = { fg = p.info },

    -- diffs
    DiffAdd    = { fg = p.git_add, bg = p.bg_float },
    DiffChange = { fg = p.git_change, bg = p.bg_float },
    DiffDelete = { fg = p.git_delete, bg = p.bg_float },
    DiffText   = { fg = p.bg, bg = p.git_change },
    Added      = { fg = p.git_add },
    Changed    = { fg = p.git_change },
    Removed    = { fg = p.git_delete },

    -- spell
    SpellBad   = { sp = p.error, undercurl = true },
    SpellCap   = { sp = p.warn, undercurl = true },
    SpellRare  = { sp = p.info, undercurl = true },
    SpellLocal = { sp = p.hint, undercurl = true },
  }
end
