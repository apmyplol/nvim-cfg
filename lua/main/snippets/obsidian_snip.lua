local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
    return
end

local s_nomath = require("main.snippets.helpers").obsidian.s_nomath

local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require "luasnip.util.events"
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.expand_conditions"

ls.add_snippets("obsidian", {
    -- snippet for markdown comment

    s_nomath(
        "math",
        c(
            1,
            {
                sn(nil, { t "$", i(1), t "$", i(0) }),
                sn(nil, { t "$$ ", i(1), t " $$", i(0) }),
                sn(nil, { t { "$$", "" }, i(1), t { "", "$$" }, i(0) }),
            }
            -- , {[-1] = {[events.leave] = function(node, _event_args) vim.inspect(print(node, _event_args)) end}})
        )
    ),
    s_nomath("adm", {
        t {
            "---",
            "tags: math/adm",
            "date: " .. os.date "%d-%m-%Y",
            "vorlesung: ",
        },
        i(1, "4"),
        t { "", "kapitel: " },
        i(2, "3.1"),
        t { "", "aliases: " },
        i(3),
        t { "", "mathlink: " },
        i(4),
        t { "", "---", "" },
        i(0),
    }),
    s_nomath("algebruh", {
        t {
            "---",
            "tags: math/algebra/einf",
            "date: " .. os.date "%d-%m-%Y",
            "vorlesung: ",
        },
        i(1, "4"),
        t { "", "kapitel: " },
        i(2, "1.3"),
        t { "", "aliases: " },
        i(3),
        t { "", "mathlink: " },
        i(4),
        t { "", "---", "" },
        i(0),
    }),
    s_nomath("topo", {
        t {
            "---",
            "tags: math/topo",
            "date: " .. os.date "%d-%m-%Y",
            "vorlesung: ",
        },
        i(1, "3"),
        t { "", "kapitel: " },
        i(2, "1"),
        t { "", "aliases: " },
        i(3),
        t { "", "mathlink: " },
        i(4),
        t { "", "---", "" },
        i(0),
    }),
    s_nomath("sml", {
        t {
            "---",
            "tags: info/sml",
            "date: " .. os.date "%d-%m-%Y",
            "vorlesung: ",
        },
        i(1, "2"),
        t { "", "kapitel: " },
        i(2, "2"),
        t { "", "aliases: " },
        i(3),
        t { "", "---", "" },
        i(0),
    }),
    s_nomath("bsp", { t "> [!example]+ ", i(1), t { "", "> " }, i(0), t "" }),
    s_nomath("summary", { t "> [!abstract]+ ", i(1), t { "", "> " }, i(0) }),
    s_nomath("def", { t "> [!important]+ Definition ", i(1), t { "", "> " }, i(0) }),
    s_nomath("rem", { t "> [!info]+ Bemerkung ", i(1), t { "", "> " }, i(0) }),
    s_nomath("warning", { t "> [!warning]+ ", i(1), t { "", "> " }, i(0) }),
    s_nomath("quote", { t "> [!quote]+ ", i(1), t { "", "> " }, i(0) }),
    s_nomath("satz", { t "> [!abstract]+ ", i(1), t { "", "> " }, i(0) }),
    -- s_nomath("lila", {t("<b><font color='#752e75'>$1</font></b>$2")}),_
    -- s_nomath("green", {t("<b><font color='#008000'>$1</font></b>$2")}),
    -- s_nomath("blau", {t("<b><font color='#0000ff'>$1</font></b>$2")}),
    -- s_nomath("rot", {t("<b><font color='#ff0000'>$1</font></b>$2")}),
    s_nomath("color", { t "<font color='", i(1), t "'>", i(2), t "</font>", i(0) }),
    s_nomath("farbe", { t "<font color='", i(1), t "'>", i(2), t "</font>", i(0) }),
})
