--
-- Copyright (c) 2010, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local mongodb = require 'mongodb'

function run(rcheck, args)
  mongodb.run_check(rcheck, args, {'asserts'})
end
