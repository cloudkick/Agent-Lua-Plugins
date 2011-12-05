--
-- Copyright (c) 2010, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local util = require 'util'
local Check = util.Check
local log = util.log
local config = require 'config'

-- XXXX: This is almost completely copied from check_config.lua :(
local function getvalue(args)
  local conf_attributes = config.get_config_attributes()

  return conf_attributes
end

function run(rcheck, args)
  local rv, r = pcall(getvalue, args)

  if rv then
    rcheck.conf = r
    rcheck:set_status('')
  else
    rcheck:set_error('failed to parse config: %s', tostring(r))
    log.err("config failed err: %s", tostring(r))
  end
  return rcheck
end
