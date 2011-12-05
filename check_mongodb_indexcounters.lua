--
-- Copyright (c) 2010, Cloudkick, Inc.
-- All right reserved.
--

module(..., package.seeall);
local mongodb = require 'mongodb'
local util = require 'util'
local Check = util.Check

function run(rcheck, args)
  mongodb.run_check(rcheck, args, {'indexcounters'})
  rcheck:pull_and_compare_error("indexcounters_missRatio", Check.op.GT, args)
end
