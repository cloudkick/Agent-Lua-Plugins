--
-- Copyright (c) 2009,2010, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local util = require 'util'
local Check = util.Check
local nicesize = util.nicesize
local log = util.log

local function getvalue(args)
  local r = {}
  equus.win32_mem_checkpoint()
  equus.win32_mem_difference()
  r["mem_total"] = equus.win32_mem_values()
  return r
end

function run(rcheck, args)
  if equus.p_is_windows() == 0 then
    rcheck:set_error("memory leak check is only supported on windows")
    return rcheck
  end

  local rv, r = pcall(getvalue, args)
  if rv then
    for k,v in pairs(r) do
      rcheck:add_metric(k, v, Check.enum.uint64)
    end
    rcheck:set_status("memory value:%s", nicesize(tonumber(r["mem_total"])))
  else
    log.err("memory check failed: %s", tostring(r))
    rcheck:set_error("%s", r)
  end
  return rcheck
end
