--
-- Copyright (c) 2010, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local mongodb = require 'mongodb'
local util = require 'util'
local Check = util.Check

function run(rcheck, args)
  mongodb.run_check(rcheck, args, {'locks'})
  rcheck:pull_and_compare_error("lock_ratio", Check.op.GT, args)
  rcheck:pull_and_compare_error("lock_lockTime", Check.op.GT, args)
  rcheck:pull_and_compare_error("lock_totalTime", Check.op.GT, args)
end
