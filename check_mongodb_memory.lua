--
-- Copyright (c) 2010, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local mongodb = require 'mongodb'
local util = require 'util'
local Check = util.Check

function run(rcheck, args)
  mongodb.run_check(rcheck, args, {'memory'})
  rcheck:pull_and_compare_error("memory_resident", Check.op.GT, args)
  rcheck:pull_and_compare_error("memory_virtual", Check.op.GT, args)
  rcheck:pull_and_compare_error("memory_mapped", Check.op.GT, args)
end
