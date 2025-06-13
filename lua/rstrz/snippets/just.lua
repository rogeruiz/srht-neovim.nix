require("luasnip.session.snippet_collection").clear_snippets("just")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("just", {
  s("windows-shell",
    fmt("set windows-shell := ['{1}', '{2}', '{3}']{}",
      { i(1, "powershell.exe"), i(2, "-NoLogo"), i(3, "-Command"), i(0) })),
  s("doc", fmt("[doc('{1}')]{}", { i(1), i(0) })),
  s("mod", fmt("mod {1} {2}{}", { i(1, "<module_name>"), i(2, "'./optional/path/to/module/.justfile'"), i(0) })),
  s("xos_shebang", fmt([[{1}_shebang := if os_family() == "windows" {{
	" {2}"
}} else {{
	"/usr/bin/env {3}"
}}{}]], { i(1, "<language_var_name>"), i(2, "<windows_binary_name>"), i(3, "<unix_binary_name>"), i(0) })),
  s("bash_shebang", fmt([[#!/usr/bin/env bash
set -euxo pipefail
{}]], { i(0) }))
})
