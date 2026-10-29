return {
  filetypes = { "c", "cpp" },
  cmd = {
    "clangd",
    "--background-index", -- index every file in compile_commands.json, so gd can reach definitions in other .c files
    "--clang-tidy",
    "--completion-style=detailed",
    -- lets clangd ask the Nix gcc/cc for its system include paths (stdio.h, pthread.h...)
    -- "--query-driver=/nix/store/**/bin/*",
    "--query-driver=/nix/store/**/bin/*,**/.devenv/profile/bin/*,/run/current-system/sw/bin/*",
  },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
}
