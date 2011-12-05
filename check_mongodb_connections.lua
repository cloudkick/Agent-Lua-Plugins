--
-- Copyright (c) 2010, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local mongodb = require 'mongodb'
local util = require 'util'
local Check = util.Check

function run(rcheck, args)
  mongodb.run_check(rcheck, args, {'connections'})
  rcheck:pull_and_compare_error("connections_current", Check.op.GT, args)
  rcheck:pull_and_compare_error("connections_available", Check.op.GT, args)
end
