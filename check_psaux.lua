--
-- Copyright (c) 2009, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local io = require 'io'
local util = require 'util'
local Check = util.Check
local log = util.log
local structs = require 'structs'

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

local function getvalue(args)
  local rv = 0
  return os.capture('ps aux', true)
end

function run(rcheck, args)
  local rv, value = pcall(getvalue, args)
  if rv then
    rcheck:add_metric('output', value, Check.enum.string)
  else
    log.err("err from psaux: %s", tostring(value))
    rcheck:set_error("%s", value)
  end
  return rcheck
end
