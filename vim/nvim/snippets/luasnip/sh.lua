---@diagnostic disable: unused-local
--# selene: allow(unused_variable)
local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

-- stylua: ignore
return {
  s("bash", {
    t { "#!/usr/bin/env bash", "" },
  }),
  s("sbash", {
    t { "#!/usr/bin/env bash", "" },
    t { "set -euo pipefail", "" },
    t { "IFS=$'\\n\\t'", "" },
  }),

  s("usage", {
    t { 'usage() { echo "Usage: $(basename "$0") <' }, i(1, "param"), t { '>" >&2; }' },
  }),

  s("sdir", {
    t { 'SDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)' },
    i(0, ' && cd "$SDIR"'),
  }),

  s("hascmd", {
    t { "hash " }, i(1, "cmd"), t { " &>/dev/null " }, i(2, "&&"),
  }),

  s("temp", {
    t { 'trap \'command rm -rf $' }, i(1, "TEMP"), t { '\' ' }, i(2, "EXIT INT TERM HUP"), t { '', '' },
    rep(1), t { '="$(mktemp -' }, i(3, "d"), t { 't ' }, i(4, '"$(basename "$0")"'), t { '.XXXXXX)"', '' },
  }),

  s("log", {
    t { 'info() { printf "' }, i(1, "$(date +%FT%T) "), t { [[%b[info]%b %s\n" ]] }, t { [['\e[0;32m\033[1m']] }, t { [[ '\e[0m' "$*" >&2; }]],  '' },
    t { 'warn() { printf "' }, rep(1),                  t { [[%b[warn]%b %s\n" ]] }, t { [['\e[0;33m\033[1m']] }, t { [[ '\e[0m' "$*" >&2; }]],  '' },
    t { 'erro() { printf "' }, rep(1),                  t { [[%b[erro]%b %s\n" ]] }, t { [['\e[0;31m\033[1m']] }, t { [[ '\e[0m' "$*" >&2; }]],  '' },
  }),

  s("shellcheck", {
    t { "# shellcheck disable=SC" }, i(1),
  }),
}
