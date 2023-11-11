local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local function copy(args)
	return args[1]
end

ls.add_snippets("plantuml", {
    s("call", {
        i(1, "caller"),
        t(" -> "),
        i(2, "callee"),
        t("++: $"),
        i(3, "func"),
        t({"", "return $"}),
        f(copy, 3),
        t({"_ret", ""}),
        i(0)
    }),
    s("def", {
        t("!$"),
        i(1, "func"),
        t(" = \""),
        i(2),
        t({"\"", "!$"}),
        f(copy, 1),
        t("_ret = \""),
        i(3),
        t({"\"", ""}),
        i(0)
    })
})
