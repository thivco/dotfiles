local function get_vue_language_server_path()
  local handle = io.popen("readlink -f $(which vue-language-server)")
  if not handle then
    return nil
  end

  local result = handle:read("*a")
  handle:close()

  if result and result ~= "" then
    local store_path = result:gsub("%s+$", ""):gsub("/bin/vue%-language%-server$", "")
    return store_path .. "/lib/language-tools/packages/language-server"
  end

  return nil
end

local vue_language_server_path = get_vue_language_server_path()

return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue"
  },
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      updateImportOnFileMove = true,
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",

            location = vue_language_server_path,
            -- location =
            -- "/nix/store/x0br1g0yg9lgms352nz2w63zpvc94a05-vue-language-server-3.1.5/lib/language-tools/packages/language-server",
            -- the above is (was ?) the correct path : it's a directory containing the package.json that is required to make vtsls work.
            languages = { "vue" },
            configNamespace = "typescript",
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
    typescript = {
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
      preferences = {
        importModuleSpecifier = "non-relative",
        updateImportsOnFileMove = {
          enabled = "always",
        },
        suggest = {
          completeFunctionCalls = true,
        },
      },
    },
  },
}
