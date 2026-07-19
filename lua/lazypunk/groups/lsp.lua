-- LSP diagnostics, references, inlay hints, and semantic token (@lsp.type.*) groups.
return function(p)
  return {
    DiagnosticError = { fg = p.error },
    DiagnosticWarn  = { fg = p.warn },
    DiagnosticInfo  = { fg = p.info },
    DiagnosticHint  = { fg = p.hint },
    DiagnosticOk    = { fg = p.ok },

    DiagnosticVirtualTextError = { fg = p.error, bg = p.bg_float },
    DiagnosticVirtualTextWarn  = { fg = p.warn, bg = p.bg_float },
    DiagnosticVirtualTextInfo  = { fg = p.info, bg = p.bg_float },
    DiagnosticVirtualTextHint  = { fg = p.hint, bg = p.bg_float },

    DiagnosticUnderlineError = { sp = p.error, undercurl = true },
    DiagnosticUnderlineWarn  = { sp = p.warn, undercurl = true },
    DiagnosticUnderlineInfo  = { sp = p.info, undercurl = true },
    DiagnosticUnderlineHint  = { sp = p.hint, undercurl = true },

    DiagnosticSignError = { fg = p.error, bg = p.bg },
    DiagnosticSignWarn  = { fg = p.warn, bg = p.bg },
    DiagnosticSignInfo  = { fg = p.info, bg = p.bg },
    DiagnosticSignHint  = { fg = p.hint, bg = p.bg },

    DiagnosticFloatingError = { fg = p.error, bg = p.bg_float },
    DiagnosticFloatingWarn  = { fg = p.warn, bg = p.bg_float },
    DiagnosticFloatingInfo  = { fg = p.info, bg = p.bg_float },
    DiagnosticFloatingHint  = { fg = p.hint, bg = p.bg_float },

    DiagnosticUnnecessary = { fg = p.comment, italic = true },
    DiagnosticDeprecated  = { fg = p.comment, strikethrough = true },

    LspReferenceText  = { bg = p.bg_sel },
    LspReferenceRead  = { bg = p.bg_sel },
    LspReferenceWrite = { bg = p.bg_sel, underline = true },
    LspInlayHint      = { fg = p.gutter, bg = p.bg_float, italic = true },
    LspCodeLens       = { fg = p.comment, italic = true },
    LspSignatureActiveParameter = { fg = p.accent, bold = true },

    -- semantic tokens
    ["@lsp.type.namespace"]     = { fg = p.type },
    ["@lsp.type.type"]          = { fg = p.type },
    ["@lsp.type.class"]         = { fg = p.type },
    ["@lsp.type.enum"]          = { fg = p.type },
    ["@lsp.type.interface"]     = { fg = p.type },
    ["@lsp.type.struct"]        = { fg = p.type },
    ["@lsp.type.typeParameter"] = { fg = p.type, italic = true },
    ["@lsp.type.parameter"]     = { fg = p.parameter },
    ["@lsp.type.variable"]      = { fg = p.variable },
    ["@lsp.type.property"]      = { fg = p.property },
    ["@lsp.type.enumMember"]    = { fg = p.constant },
    ["@lsp.type.function"]      = { fg = p.func },
    ["@lsp.type.method"]        = { fg = p.func },
    ["@lsp.type.macro"]         = { fg = p.preproc },
    ["@lsp.type.keyword"]       = { fg = p.keyword },
    ["@lsp.type.comment"]       = { fg = p.comment, italic = true },
    ["@lsp.type.string"]        = { fg = p.string },
    ["@lsp.type.number"]        = { fg = p.number },
    ["@lsp.type.operator"]      = { fg = p.operator },
    ["@lsp.type.decorator"]     = { fg = p.preproc },
    ["@lsp.mod.readonly"]       = { fg = p.constant },
    ["@lsp.mod.deprecated"]     = { strikethrough = true },
  }
end
