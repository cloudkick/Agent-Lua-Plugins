--
-- Copyright (c) 2009, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local alien = require 'alien'
local util = require 'util'
local Check = util.Check
local log = util.log

local function getvalue(args)
  local libc = alien.default
  local load = alien.array("double", 4)
  libc.getloadavg:types("int", "pointer", "int")
  local rv = libc.getloadavg(load.buffer, 3)

  if rv < 0 then
    error("libc.getloadavg returned ".. rv)
  end
  return load
end

function run(rcheck, args)
  if equus.p_is_windows() == 1 then
    rcheck:set_error("loadaverage check is only supported on linux")
    return rcheck
  end
  local rv, value = pcall(getvalue, args)
  if rv then
    rcheck:add_metric('loadaverage_1m', value[1], Check.enum.double)
    rcheck:add_metric('loadaverage_5m', value[2], Check.enum.double)
    rcheck:add_metric('loadaverage_15m', value[3], Check.enum.double)
    rcheck:set_status('load average: %.2f, %.2f, %.2f', value[1], value[2], value[3])
  else 
    log.err("getloadav failed err: %s", tostring(value))
    rcheck:set_error("%s", value)
  end
  return rcheck
end
