--
-- Copyright (c) 2010, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local util = require 'util'

function failed_connecting(line)
  local match1, match2, match3 = nil, nil, nil

  _, _, match1 = line:lower():find('.*(error connecting).*')
  _, _, match2 = line:lower():find('.*(connection refused).*')
  _, _, match3 = line:lower():find('.*(connection timeout).*')

  if match1 or match2 or match3 then
    return true
  end

  return false
end
