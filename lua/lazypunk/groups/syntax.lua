-- Legacy vim syntax groups (fallback for filetypes without treesitter).
return function(p)
  return {
    Comment = { fg = p.comment, italic = true },

    Constant  = { fg = p.constant },
    String    = { fg = p.string },
    Character = { fg = p.string },
    Number    = { fg = p.number },
    Float     = { fg = p.number },
    Boolean   = { fg = p.number },

    Identifier = { fg = p.fg },
    Function   = { fg = p.func },

    Statement   = { fg = p.keyword },
    Conditional = { fg = p.keyword },
    Repeat      = { fg = p.keyword },
    Label       = { fg = p.keyword },
    Operator    = { fg = p.operator },
    Keyword     = { fg = p.keyword },
    Exception   = { fg = p.keyword },

    PreProc   = { fg = p.preproc },
    Include   = { fg = p.preproc },
    Define    = { fg = p.preproc },
    Macro     = { fg = p.preproc },
    PreCondit = { fg = p.preproc },

    Type         = { fg = p.type },
    StorageClass = { fg = p.keyword },
    Structure    = { fg = p.type },
    Typedef      = { fg = p.type },

    Special        = { fg = p.accent2 },
    SpecialChar    = { fg = p.accent2 },
    Tag            = { fg = p.keyword },
    Delimiter      = { fg = p.operator },
    SpecialComment = { fg = p.fg_dim, italic = true },
    Debug          = { fg = p.error },

    Underlined = { fg = p.func, underline = true },
    Ignore     = { fg = p.comment },
    Error      = { fg = p.error, bold = true },
    Todo       = { fg = p.bg, bg = p.warn, bold = true },
  }
end
