local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

function command(t, command) 
    return s(t, fmta("\\" .. command .. "{<>}", {i(1)}))
end

local table_node= function(args)
	local tabs = {}
	local count
	table = args[1][1]:gsub("%s",""):gsub("|","")
	count = table:len()
	for j=1, count do
		local iNode
		iNode = i(j)
		tabs[2*j-1] = iNode
		if j~=count then
			tabs[2*j] = t" & "
		end
	end
	return sn(nil, tabs)
end

local rec_table = function ()
	return sn(nil, {
		c(1, {
			t({""}),
			sn(nil, {t{"\\\\",""} ,d(1,table_node, {ai[1]}), d(2, rec_table, {ai[1]})})
		}),
	});
end

function begin_auto(t, env)
    return s({
        trig = t,
    },
    fmta(
    [[
        \begin{]] .. env .. [[}
            <>
        \end{]] .. env .. [[}
    ]], {
        i(1),
    }))
end

function begin_with_arg(t, env)
    return s({
        trig = t,
    },
    fmta(
    [[
        \begin{]] .. env .. [[}{<>}
            <>
        \end{]] .. env .. [[}
    ]], {
        i(1),
        i(2),
    }))
end

return {
    s({
        trig = "be",
    },
    fmta(
    [[
        \begin{<>}
            <>
        \end{<>}
    ]], {
        i(1),
        i(2),
        rep(1),
    })),

    s({
        trig = "bi",
    }, 
    fmta(
    [[
        \begin{itemize}
            \item <>
        \end{itemize}
    ]], {
        i(1)
    })),
    s({
        trig = "i",
    }, 
    fmta([[ \item ]], {})),

    begin_auto("fr", "frame"),
    begin_auto("eq", "equation"),
    begin_auto("al", "align"),
    begin_auto("ga", "gather"),
    command("sec", "section"),
    command("ssec", "subsection"),
    command("sssec", "subsubsection"),
    command("fti", "frametitle"),
    command("fsti", "framesubtitle"),
    begin_with_arg("blk", "block"),
    begin_with_arg("ablk", "alertblock"),
    begin_with_arg("eblk", "exampleblock"),

    s(
        {trig = "tab(%u+)", regTrig = true},
        fmta([[
        \begin{tabular}{<>}
            <>
        \end{tabular}
        ]], {
            f(function(_, snip)
                print(snip.captures)
                return ""
            end),
            i(1)

        })
    ),
    s("table", {
        t"\\begin{tabular}{",
        i(1,"0"),
        t{"}",""},
        d(2, table_node, {1}, {}),
        d(3, rec_table, {1}),
        t{"","\\end{tabular}"}
    }),
}

