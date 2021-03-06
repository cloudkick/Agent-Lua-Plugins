--
-- Copyright 2010, Cloudkick, Inc.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

module(..., package.seeall);
local stage0 = require 'stage0'

function get_config_attributes()
  local conf_attributes = {}
  conf_attributes.config_file = stage0.pick_config()
  stage0.process_argv(conf_attributes)

  if conf_attributes.config_file ~= nil then
    conf_attributes = stage0.loadconf(conf_attributes.config_file)
  end

  return conf_attributes
end
