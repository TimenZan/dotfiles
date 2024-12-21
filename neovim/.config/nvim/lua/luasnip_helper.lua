-- This file is adapted from https://ejmastnak.com/tutorials/vim-latex/luasnip


local res = {}

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
local line_begin = require("luasnip.extras.expand_conditions").line_begin


--- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
--- returns an insert node whose initial text is set to the visual selection.
--- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
res.get_visual = function (_, parent)
    if (#parent.snippet.env.LS_SELECT_RAW > 0) then
        return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
    else -- If LS_SELECT_RAW is empty, return a blank insert node
        return sn(nil, i(1))
    end
end

res.aus = function (trig, snip, opts)
    trig.snippetType = trig.snippetType or "autosnippet"
    return s(trig, snip, opts)
end

local tex = {}

--- Math environment
tex.in_mathzone = function ()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

--- Inside regular text (i.e. not math)
tex.in_text = function ()
    return not tex.in_mathzone()
end

--- Inside a comment
tex.in_comment = function ()
    return vim.fn['vimtex#syntax#in_comment']() == 1
end

--- Generic environment detection
tex.in_env = function (name)
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

--- Equation environment
tex.in_equation = function ()
    return tex.in_env('equation')
end

--- Itemize environment
tex.in_itemize = function ()
    return tex.in_env('itemize')
end

--- TikZ picture environment
tex.in_tikz = function ()
    return tex.in_env('tikzpicture')
end

tex.maths = function (trig, snip, opts)
    opts = opts or {}
    opts.condition = opts.condition or tex.in_mathzone
    return s(trig, snip, opts)
end

tex.texts = function (trig, snip, opts)
    opts = opts or {}
    opts.condition = opts.condition or tex.in_text
    return s(trig, snip, opts)
end

tex.mathaus = function (tr, snip, opts)
    if type(tr) == "string" then
        tr = { trig = tr }
    end
    tr.snippetType = tr.snippetType or "autosnippet"
    return tex.maths(tr, snip, opts)
end

tex.textaus = function (tr, snip, opts)
    if type(tr) == "string" then
        tr = { trig = tr }
    end
    tr.snippetType = tr.snippetType or "autosnippet"
    return tex.texts(tr, snip, opts)
end

tex.mathalias = function (name, repl)
    return tex.mathaus(name, t(repl), {})
end

tex.textalias = function (name, repl)
    return res.textaus(name, t(repl))
end

res.tex = tex

return res
