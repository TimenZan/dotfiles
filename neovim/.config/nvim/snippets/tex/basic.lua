local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin


local rec_ls
rec_ls = function ()
    return sn(nil, {
        c(1, {
            -- important!! Having the sn(...) as the first choice will cause infinite recursion.
            t({ "" }),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        }),
    });
end


local u = require 'luasnip_helper'
local tex = u.tex

local snips = {}


table.insert(snips,
    -- A fun zero subscript snippet
    s({ trig = '([%a%)%]%}])00', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
        fmta(
            "<>_{<>}",
            {
                f(function (_, snip) return snip.captures[1] end),
                t("0")
            },
            { condition = tex.in_mathzone, }
        )
    )
)

table.insert(snips,
    s({ trig = 'subrom', snippetType = "autosnippet", wordTrig = false },
        fmta("_{\\mathrm{<>}}",
            { d(1, u.get_visual) }
        ),
        { condition = tex.in_mathzone }
    )
)

table.insert(snips,
    s({ trig = 'rom', snippetType = "autosnippet", wordTrig = true },
        fmta("\\mathrm{<>}",
            { d(1, u.get_visual) }
        ),
        { condition = tex.in_mathzone }
    )
)

table.insert(snips,
    s({ trig = 'sff', snippetType = "autosnippet", wordTrig = true },
        fmta("\\mathsf{<>}",
            { d(1, u.get_visual) }
        ),
        { condition = tex.in_mathzone }
    )
)

table.insert(snips,
    s({ trig = 'call', snippetType = "autosnippet", wordTrig = true },
        fmta("\\mathcal{<>}",
            { d(1, u.get_visual) }
        ),
        { condition = tex.in_mathzone }
    )
)

table.insert(snips,
    tex.textaus({ trig = 'mm', wordTrig = true },
        fmta("\\(<>\\)",
            { d(1, u.get_visual) }
        )
    )
)

table.insert(snips, s("ls",
    t({ "\\begin{itemize}",
        "\t\\item " }), i(1), d(2, rec_ls, {}),
    t({ "", "\\end{itemize}" }), i(0)
))


local dynamic_postfix = function (_, parent, _, user_arg1, user_arg2)
    local capture = parent.snippet.env.POSTFIX_MATCH
    if #capture > 0 then
        return sn(nil, fmta([[
        <><><><>
        ]],
            { t(user_arg1), t(capture), t(user_arg2), i(0) }))
    else
        local visual_placeholder = ""
        if #parent.snippet.env.SELECT_RAW > 0 then
            visual_placeholder = parent.snippet.env.SELECT_RAW
        end
        return sn(nil, fmta([[
        <><><><>
        ]],
            { t(user_arg1), i(1, visual_placeholder), t(user_arg2), i(0) }))
    end
end

--- Takes in a LaTeX command and returns a postfix autosnippet in the form of `:command`
--- TODO: doesn't work
--- @param command string
local pf = function (command)
    return s({ trig = ":" .. command, snippetType = "autosnippet" },
        { d(1, dynamic_postfix, {}, { user_args = { string.format("\\%s{", command), "}" } }) },
        { condition = tex.in_math, show_condition = tex.in_math }
    )
end

local postfix_cmds = { "vec", "bar", "hat", }

for _, cmd in pairs(postfix_cmds) do
    table.insert(snips, pf(cmd))
end


-- TODO(???): only add space if followed by alphabetical character??
local math_aliases = {
    xx = "\\times "
}

for key, value in pairs(math_aliases) do
    table.insert(snips, tex.mathalias(key, value))
end

-- TODO: allow for selection of text
table.insert(snips,
    s({ trig = "figdouble", desc = "Two items side by side" },
        fmta([[
\begin{figure}[h]
	\begin{minipage}{0.4\linewidth}
        <>
	\end{minipage}
	\begin{minipage}{0.4\linewidth}
        <>
	\end{minipage}
\end{figure}
        ]],
            { i(1), i(2) })
    )
)


-- TODO: snippet that turns XXX_aa into XXX_{aa}
-- TODO: snippet that turns 1a into 1_a


return snips
