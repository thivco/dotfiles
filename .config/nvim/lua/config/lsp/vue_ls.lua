return {
  filetypes = { "vue" },
  init_options = {
    typescript = {
      tsdk = "/nix/store/hl69bzlr5ijvsvjcc1z24qrkxs4xdlyp-typescript-5.8.3/lib/node_modules/typescript/lib/"
    },
    vue = {
      hybridMode = true,
    }
  },
  settings = {
    -- vue = { useWorkspaceTsdk = true },
    emmet = {
      showExpandedAbbreviation = "never",
    },
  },
}
