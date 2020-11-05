package = "kong-plugin-moleculer-bridge"
version = "0.1.0-1"
-- TODO: renumber, must match the info in the filename of this rockspec!
-- The version '0.1.0' is the source code version, the trailing '1' is the version of this rockspec.
-- whenever the source version changes, the rockspec should be reset to 1. The rockspec version is only
-- updated (incremented) when this file changes, but the source remains the same.

local pluginName = package:match("^kong%-plugin%-(.+)$")

supported_platforms = {"linux"}
source = {
  url = "",
}

description = {
  summary = "idk",
  homepage = "",
  license = ""
}

dependencies = {
  "uuid",
  "nats",
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins." .. pluginName .. ".handler"] = "kong/plugins/" .. pluginName .. "/handler.lua",
    ["kong.plugins." .. pluginName .. ".schema"] = "kong/plugins/" .. pluginName .. "/schema.lua",
    ["kong.plugins." .. pluginName .. ".moleculer"] = "kong/plugins/" .. pluginName .. "/moleculer.lua",
  }
}
