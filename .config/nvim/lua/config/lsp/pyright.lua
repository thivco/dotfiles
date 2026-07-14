return {
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
-- return {
--   filetypes = { "python" },
--   root_markers = {
--     "pyproject.toml",
--     "setup.py",
--     "setup.cfg",
--     "requirements.txt",
--     "Pipfile",
--     ".git",
--   },
--   settings = {
--     basedpyright = {
--       analysis = {
--         typeCheckingMode = "standard",
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         diagnosticSeverityOverrides = {
--           reportUnknownVariableType = "none",
--           reportUnknownArgumentType = "none",
--           reportUnknownParameterType = "none",
--           reportUnknownMemberType = "none",
--           reportMissingParameterType = "none",
--           reportUnusedImport = "none",
--         },
--         diagnosticMode = "openFilesOnly",
--       },
--     },
--   },
-- }
