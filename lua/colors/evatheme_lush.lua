local lush = require "lush"
local hsl = lush.hsl

local evacolors = {
    alacbg = hsl "#4D427D",
    alacfg = hsl "#B3ACD8",
    -- 初号機 colors
    oldpurple = hsl "#765898",
    oldpurple2 = hsl "#965fd4",
    purple1 = hsl "#A877C8",
    purple2 = hsl "#B1A8DD",
    reb_purple1 = hsl "#775899",
    reb_purple2 = hsl "#7573A3",
    green = hsl "#A3DA58",
    orange = hsl "#F7BA2D",
    black = hsl "#000000",
    white = hsl "#FFFFFF",
    red = hsl "#FF0000",
    reb_green = hsl "#54CF51",
    reb_orange = hsl "#ff8c28",
    -- 二号機 colors
    eva2 = {
        red = hsl "#A3001C",
        orange = hsl "#EC6C2B",
        purple = hsl "#8866A2",
        reb_purp = hsl "#74738D",
    },
    -- 零号機 colors
    eva0 = {
        blue = hsl "#7999f2",
        grey = hsl "#B8C297",
    },
}

local ec = evacolors

--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
    return {
        -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
        -- groups, mostly used for styling UI elements.
        -- Comment them out and add your own properties to override the defaults.
        -- An empty definition `{}` will clear all styling, leaving elements looking
        -- like the 'Normal' group.
        -- To be able to link to a group, it must already be defined, so you may have
        -- to reorder items as you go.
        --
        -- See :h highlight-groups

        -- ColorColumn  { }, -- Columns set with 'colorcolumn'
        Conceal {}, -- Placeholder characters substituted for concealed text (see 'conceallevel')
        -- Cursor       { fg = ec.green }, -- Character under the cursor
        -- lCursor      { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
        -- CursorIM     { fg = ec.green }, -- Like Cursor, but used when in IME mode |CursorIM|
        CursorColumn { bg = ec.alacbg.da(10) }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine { bg = ec.alacbg.da(10) }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory { fg = ec.oldpurple.li(10).ro(30) }, -- Directory names (and other special names in listings)
        -- DiffAdd      { }, -- Diff mode: Added line |diff.txt|
        -- DiffChange   { }, -- Diff mode: Changed line |diff.txt|
        -- DiffDelete   { }, -- Diff mode: Deleted line |diff.txt|
        -- DiffText     { }, -- Diff mode: Changed text within a changed line |diff.txt|
        EndOfBuffer { fg = ec.red }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        -- BufferCurrent = {fg = ec.green},
        -- background = { bg = ec.black, fg = ec.black },
        -- TermCursor   { }, -- Cursor in a focused terminal
        -- TermCursorNC { }, -- Cursor in an unfocused terminal
        ErrorMsg { bg = ec.red, fg = ec.black }, -- Error messages on the command line
        VertSplit { fg = ec.orange }, -- Column separating vertically split windows
        HorizSplit { fg = ec.orange },
        Folded { bg = ec.green.da(20), fg = ec.black }, -- Line used for closed folds
        -- FoldColumn   { }, -- 'foldcolumn'
        SignColumn { bg = ec.alacbg.da(10) }, -- Column where |signs| are displayed
        -- IncSearch    { }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        -- Substitute   { }, -- |:substitute| replacement text highlighting
        LineNr { fg = ec.alacfg.da(30) }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr { fg = ec.orange, bg = CursorColumn.bg }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        -- MatchParen   { }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
        -- MsgArea      { }, -- Area for messages and cmdline
        -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        -- MoreMsg      { }, -- |more-prompt|
        -- NonText      { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal { bg = ec.alacbg, fg = ec.alacfg }, -- Normal text
        NormalFloat {}, -- Normal text in floating windows.
        -- NormalNC     { }, -- normal text in non-current windows
        Pmenu { bg = ec.alacbg.da(10) }, -- Popup menu: Normal item.
        PmenuSel { bg = ec.alacbg.li(10) }, -- Popup menu: Selected item.
        PmenuSbar { bg = ec.orange.da(20), fg = ec.black }, -- Popup menu: Scrollbar.
        PmenuThumb { bg = ec.green.da(20), fg = ec.black }, -- Popup menu: Thumb of the scrollbar.
        -- Question     { }, -- |hit-enter| prompt and yes/no questions
        -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search { bg = hsl "#00DD00", fg = ec.black }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        -- SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        -- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        -- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        -- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        -- StatusLine   { bg=ec.alacbg, fg=ec.green }, -- Status line of current window
        -- StatusLineNC { fg = ec.orange }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine { fg = ec.alacfg, bg = ec.alacbg }, -- Tab pages line, not active tab page label
        TabLineFill {}, -- Tab pages line, where there are no labels
        -- TabLineSel   { fg = ec.green, bg = ec.green }, -- Tab pages line, active tab page label
        -- Title        { }, -- Titles for output from ":set all", ":autocmd" etc.
        Visual { bg = ec.green, fg = ec.black.li(20), gui = "italic, reverse" }, -- Visual mode selection
        -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
        -- WarningMsg   { }, -- Warning messages
        Whitespace { bg = ec.black }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Winseparator { fg = ec.reb_orange }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
        -- WildMenu     { }, -- Current match in 'wildmenu' completion

        -- Common vim syntax groups used for all kinds of code and markup.
        -- Commented-out groups should chain up to their preferred (*) group
        -- by default.
        --
        -- See :h group-name
        --
        -- Uncomment and edit if you want more specific syntax highlighting.

        Comment { fg = ec.eva2.reb_purp.da(7) }, -- Any comment
        Constant {}, -- (*) Any constant
        String { fg = ec.orange.da(30), italic = true }, --   A string constant: "this is a string"
        Character {}, --   A character constant: 'c', '\n'
        Number {}, --   A number constant: 234, 0xff
        Boolean {}, --   A boolean constant: TRUE, false
        Float {}, --   A floating point constant: 2.3e10
        Identifier { fg = ec.reb_green }, -- (*) Any variable name
        Function { fg = ec.reb_green.da(20), gui = "bold" }, --   Function name (also: methods for classes)
        Statement { fg = ec.oldpurple2 }, -- (*) Any statement
        Conditional { fg = ec.oldpurple2 }, --   if, then, else, endif, switch, etc.
        -- Repeat         { }, --   for, do, while, etc.
        -- Label          { }, --   case, default, etc.
        -- Operator       { }, --   "sizeof", "+", "*", etc.
        -- Keyword        { }, --   any other keyword
        -- Exception      { }, --   try, catch, throw

        PreProc { fg = hsl("#00FF00").da(15), gui = "bold" }, -- (*) Generic Preprocessor
        -- Include        { }, --   Preprocessor #include
        -- Define         { }, --   Preprocessor #define
        -- Macro          { }, --   Same as Define
        -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

        Type { fg = hsl "#00FF00" }, -- (*) int, long, char, etc.
        -- StorageClass   { }, --   static, register, volatile, etc.
        -- Structure      { }, --   struct, union, enum, etc.
        -- Typedef        { }, --   A typedef

        -- Special        { }, -- (*) Any special symbol
        -- SpecialChar    { }, --   Special character in a constant
        -- Tag            { }, --   You can use CTRL-] on this
        -- Delimiter      { }, --   Character that needs attention
        -- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
        -- Debug          { }, --   Debugging statements

        Underlined { fg = ec.eva0.blue, gui = "underline" }, -- Text that stands out, HTML links
        -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        Error { fg = ec.black, bg = ec.red }, -- Any erroneous construct
        -- Todo           { }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        -- These groups are for the native LSP client and diagnostic system. Some
        -- other LSP clients may use these groups, or use their own. Consult your
        -- LSP client's documentation.

        -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
        --
        LspReferenceText {}, -- Used for highlighting "text" references
        LspReferenceRead {}, -- Used for highlighting "read" references
        LspReferenceWrite {}, -- Used for highlighting "write" references
        LspCodeLens {}, -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        LspCodeLensSeparator {}, -- Used to color the seperator between two or more code lens.
        LspSignatureActiveParameter {}, -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.
        -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        DiagnosticError { fg = ec.eva2.red, bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticWarn { fg = ec.reb_orange, bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticInfo { fg = ec.eva0.grey, bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticHint { fg = ec.eva0.blue, bold = true }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
        -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
        -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
        -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
        -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
        -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
        -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
        -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
        -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
        -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
        -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
        -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.

        -- Tree-Sitter syntax groups. Most link to corresponding
        -- vim syntax groups (e.g. TSKeyword => Keyword) by default.
        --
        -- See :h nvim-treesitter-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- TSAttribute          { } , -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
        -- TSBoolean            { } , -- Boolean literals: `True` and `False` in Python.
        -- TSCharacter          { } , -- Character literals: `'a'` in C.
        -- TSCharacterSpecial   { } , -- Special characters.
        -- TSComment            { } , -- Line comments and block comments.
        -- TSConditional        { } , -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
        -- TSConstant           { } , -- Constants identifiers. These might not be semantically constant. E.g. uppercase variables in Python.
        -- TSConstBuiltin       { } , -- Built-in constant values: `nil` in Lua.
        -- TSConstMacro         { } , -- Constants defined by macros: `NULL` in C.
        -- TSConstructor        { } , -- Constructor calls and definitions: `{}` in Lua, and Java constructors.
        -- TSDebug              { } , -- Debugging statements.
        -- TSDefine             { } , -- Preprocessor #define statements.
        -- TSError              { } , -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
        -- TSException          { } , -- Exception related keywords: `try`, `except`, `finally` in Python.
        -- TSField              { } , -- Object and struct fields.
        -- TSFloat              { } , -- Floating-point number literals.
        -- TSFunction           { } , -- Function calls and definitions.
        -- TSFuncBuiltin        { } , -- Built-in functions: `print` in Lua.
        -- TSFuncMacro          { } , -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
        -- TSInclude            { } , -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
        -- TSKeyword            { } , -- Keywords that don't fit into other categories.
        -- TSKeywordFunction    { } , -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
        -- TSKeywordOperator    { } , -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
        -- TSKeywordReturn      { } , -- Keywords like `return` and `yield`.
        -- TSLabel              { } , -- GOTO labels: `label:` in C, and `::label::` in Lua.
        -- TSMethod             { } , -- Method calls and definitions.
        -- TSNamespace          { } , -- Identifiers referring to modules and namespaces.
        -- TSNone               { } , -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
        -- TSNumber             { } , -- Numeric literals that don't fit into other categories.
        -- TSOperator           { } , -- Binary or unary operators: `+`, and also `->` and `*` in C.
        -- TSParameter          { } , -- Parameters of a function.
        -- TSParameterReference { } , -- References to parameters of a function.
        -- TSPreProc            { } , -- Preprocessor #if, #else, #endif, etc.
        -- TSProperty           { } , -- Same as `TSField`.
        -- TSPunctDelimiter     { } , -- Punctuation delimiters: Periods, commas, semicolons, etc.
        -- TSPunctBracket       { } , -- Brackets, braces, parentheses, etc.
        -- TSPunctSpecial       { } , -- Special punctuation that doesn't fit into the previous categories.
        -- TSRepeat             { } , -- Keywords related to loops: `for`, `while`, etc.
        -- TSStorageClass       { } , -- Keywords that affect how a variable is stored: `static`, `comptime`, `extern`, etc.
        -- TSString             { } , -- String literals.
        -- TSStringRegex        { } , -- Regular expression literals.
        -- TSStringEscape       { } , -- Escape characters within a string: `\n`, `\t`, etc.
        -- TSStringSpecial      { } , -- Strings with special meaning that don't fit into the previous categories.
        -- TSSymbol             { } , -- Identifiers referring to symbols or atoms.
        -- TSTag                { } , -- Tags like HTML tag names.
        -- TSTagAttribute       { } , -- HTML tag attributes.
        -- TSTagDelimiter       { } , -- Tag delimiters like `<` `>` `/`.
        -- TSText               { } , -- Non-structured text. Like text in a markup language.
        -- TSStrong             { } , -- Text to be represented in bold.
        -- TSEmphasis           { } , -- Text to be represented with emphasis.
        -- TSUnderline          { } , -- Text to be represented with an underline.
        -- TSStrike             { } , -- Strikethrough text.
        -- TSTitle              { } , -- Text that is part of a title.
        -- TSLiteral            { } , -- Literal or verbatim text.
        -- TSURI                { } , -- URIs like hyperlinks or email addresses.
        -- TSMath               { } , -- Math environments like LaTeX's `$ ... $`
        -- TSTextReference      { } , -- Footnotes, text references, citations, etc.
        -- TSEnvironment        { } , -- Text environments of markup languages.
        -- TSEnvironmentName    { } , -- Text/string indicating the type of text environment. Like the name of a `\begin` block in LaTeX.
        -- TSNote               { } , -- Text representation of an informational note.
        -- TSWarning            { } , -- Text representation of a warning note.
        -- TSDanger             { } , -- Text representation of a danger note.
        -- TSType               { } , -- Type (and class) definitions and annotations.
        -- TSTypeBuiltin        { } , -- Built-in types: `i32` in Rust.
        -- TSVariable           { } , -- Variable names that don't fit into other categories.
        -- TSVariableBuiltin    { } , -- Variable names defined by the language: `this` or `self` in Javascript.

        ------------------------------------------- Nvim-tree stuff ----------------------------------------------------
        NvimTreeSymlink { fg = ec.orange },
        NvimTreeRootFolder { fg = ec.oldpurple.li(10).ro(30), bold = true, underline = true },
        NvimTreeFolderIcon { fg = ec.oldpurple.li(10).ro(30) }, -- Directory names (and other special names in listings)
        NvimTreeOpenedFolderIcon { fg = ec.oldpurple.li(30).ro(30) }, -- (NvimTreeFolderIcon)
        NvimTreeOpenedFolderName { fg = ec.oldpurple.li(30).ro(30) }, --  (Directory)
        NvimTreeClosedFolderIcon { fg = ec.oldpurple.da(10).ro(30) }, -- (NvimTreeFolderIcon)
        -- NvimTreeFileIcon
        -- NvimTreeEmptyFolderName     (Directory)
        NvimTreeExecFile { fg = ec.green },
        -- NvimTreeOpenedFile { fg = ec.green }
        -- NvimTreeModifiedFile
        -- NvimTreeSpecialFile
        -- NvimTreeImageFile
        -- NvimTreeIndentMarker

        -- NvimTreeLspDiagnosticsError         (DiagnosticError)
        -- NvimTreeLspDiagnosticsWarning       (DiagnosticWarn)
        -- NvimTreeLspDiagnosticsInformation   (DiagnosticInfo)
        -- NvimTreeLspDiagnosticsHint          (DiagnosticHint)

        NvimTreeGitDirty { fg = ec.green },
        NvimTreeGitStaged { fg = ec.green, bold = true, italic = true },
        -- NvimTreeGitMerge
        -- NvimTreeGitRenamed
        NvimTreeGitNew { fg = ec.white },
        -- NvimTreeGitDeleted
        NvimTreeGitIgnored { fg = ec.black }, --  (Comment)
        -- NvimTreeWindowPicker

        -- There are also links to normal bindings to style the tree itself.

        -- NvimTreeNormal
        -- NvimTreeEndOfBuffer     (NonText)
        -- NvimTreeCursorLine      (CursorLine)
        -- NvimTreeCursorLineNr    (CursorLineNr)
        -- NvimTreeLineNr          (LineNr)
        -- NvimTreeWinSeparator    (WinSeparator)
        -- NvimTreeCursorColumn    (CursorColumn)

        -- There are also links for file highlight with git properties, linked to their
        -- Git equivalent:

        -- NvimTreeFileDirty       (NvimTreeGitDirty)
        -- NvimTreeFileStaged      (NvimTreeGitStaged)
        -- NvimTreeFileMerge       (NvimTreeGitMerge)
        -- NvimTreeFileRenamed     (NvimTreeGitRenamed)
        -- NvimTreeFileNew         (NvimTreeGitNew)
        -- NvimTreeFileDeleted     (NvimTreeGitDeleted)
        -- NvimTreeFileIgnored     (NvimTreeGitIgnored)

        ---------------- lualine stuff -----------------

        LualineNormal { bg = ec.reb_purple1, fg = ec.alacfg },
        LualineInsert { bg = ec.reb_green, fg = ec.alacbg.da(40) },
        LualineVisual { bg = ec.purple1, fg = ec.alacbg.da(40) },
        LualineReplace { bg = ec.alacbg, fg = ec.alacfg },
        LualineCommand { bg = ec.reb_orange, fg = ec.alacbg },
        LualineInactive { bg = ec.reb_purple1.da(40), fg = ec.alacfg.da(20) },
        ------------------ Obsidian Stuff -------------------
        ObsH1 { bg = ec.alacbg, fg = ec.oldpurple2.ro(90), bold = true },
        ObsH2 { bg = ec.alacbg, fg = ec.oldpurple2.ro(30), bold = true },
        ObsH3 { bg = ec.alacbg, fg = ec.oldpurple2, bold = true },
        ObsH4 { bg = ec.alacbg, fg = ec.oldpurple2.ro(-20), bold = true },
        ObsH5 { bg = ec.alacbg, fg = ec.oldpurple2.ro(-20).li(20), bold = true },
        ObsTag { bg = ec.reb_orange.da(30), fg = ec.alacbg },
        ObsYamlFM { bg = ec.alacbg.li(10), fg = ec.alacfg.da(10) },
        ObsTextBlockRef { bg = ec.alacbg.da(10), fg = ec.white.da(30), italic = true },
        ObsLinkName { bg = ec.alacbg, fg = ec.reb_green.li(30), underline = true },
        ObsLinkDest { bg = ec.alacbg, fg = ec.reb_green, underline = true },
        ObsLinkNoRename { bg = ec.alacbg, fg = ec.reb_green.li(30), underline = true },
        ObsLinkRename { bg = ec.alacbg, fg = ec.reb_green.li(30), underline = true },
        ObsCalloutHeadline {},
        ObsCalloutTitle { bold = true },
        TexLink { bold = true },
        ObsBold { bold = true },
        ObsItalics { italic = true },
        ObsBoldItalics { bold = true, italic = true },
        ObsSingleTicks {bg = ec.black.li(15).ro(50)},
        ObsTriTicksDelim {fg=ec.reb_green.ro(-20), bold=true, bg=ec.black},
        ObsPyBlockDelim {fg=ec.reb_green.ro(-20), bold=true, bg=ec.black},
        -- callout stuffs
        ObsCalloutNote { bold = true },
        ObsCalloutAbstract { bold = true },
        ObsCalloutSummary { bold = true },
        ObsCalloutTldr { bold = true },
        ObsCalloutInfo { bold = true },
        ObsCalloutTodo { bold = true },
        ObsCalloutTip { bold = true },
        ObsCalloutHint { bold = true },
        ObsCalloutImportant { bold = true },
        ObsCalloutSuccess { bold = true },
        ObsCalloutCheck { bold = true },
        ObsCalloutDone { bold = true },
        ObsCalloutQuestion { bold = true },
        ObsCalloutHelp { bold = true },
        ObsCalloutFaq { bold = true },
        ObsCalloutWarning { bold = true },
        ObsCalloutCaution { bold = true },
        ObsCalloutAttention { bold = true },
        ObsCalloutFailure { bold = true },
        ObsCalloutFail { bold = true },
        ObsCalloutMissing { bold = true },
        ObsCalloutDanger { bold = true },
        ObsCalloutError { bold = true },
        ObsCalloutBug { bold = true },
        ObsCalloutExample { bold = true },
        ObsCalloutQuote { bold = true },
        ObsCalloutCite { bold = true },
    }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
