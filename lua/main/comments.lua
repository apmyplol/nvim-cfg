local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

local status_ok, commentft = pcall(require, "Comment.ft")
if not status_ok then
  return
end

-- TODO: fix comments.lua/which key, blockwise and line comments are weird
--commentft.matlab = {"%%s", "%{\n%s\n%}"}
--
commentft.lua = {"--%s"}

-- comment.setup {
--   pre_hook = function(ctx)
--     local U = require "Comment.utils"
-- 
--     local location = nil
--     if ctx.ctype == U.ctype.block then
--       location = require("ts_context_commentstring.utils").get_cursor_location()
--     elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
--       location = require("ts_context_commentstring.utils").get_visual_start_location()
--     end
-- 
--     return require("ts_context_commentstring.internal").calculate_commentstring {
--       key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
--       location = location,
--     }
--   end,
-- }
