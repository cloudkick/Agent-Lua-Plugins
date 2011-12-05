--
-- Copyright (c) 2009, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local util = require 'util'
local Check = util.Check
local log = util.log
local io = require 'io'

local function getvalue(args)
  local r = {}
  local count = 0
  -- See iostats.txt: 
  --     <http://fxr.watson.org/fxr/source/Documentation/iostats.txt?v=linux-2.6>

  file = assert(io.open("/proc/diskstats", "r"))
  for line in file:lines() do
    l = util.split(line)
    -- skip all devices with 0 reads
    if l[4] ~= '0' then
      -- log.dbg("device: %s", l[3])
      r[l[3] .. "_reads"] = l[4]
      r[l[3] .. "_writes"] = l[8]
      count = count + 1
    end
  end
  file:close()
  return r, count
end

function run(rcheck, args)
  if equus.p_is_linux() == 0 then
    rcheck:set_error("io check is only supported on linux")
    return rcheck
  end
  local rv, r, count = pcall(getvalue, args)
  if rv then
    for k,v in pairs(r) do
      rcheck:add_metric(k, v, Check.enum.gauge)
    end
    rcheck:set_status("%d block devices found", count)
  else
    log.err("io failed err: %s", tostring(r))
    rcheck:set_error("%s", r)
  end
  return rcheck
end
