-- https://docs.konghq.com/2.2.x/plugin-development/custom-logic/#available-contexts

-- Extending the Base Plugin handler is optional, as there is no real
-- concept of interface in Lua, but the Base Plugin handler's methods
-- can be called from your child implementation and will print logs
-- in your `error.log` file (where all logs are printed).

local json = require 'cjson'
local BasePlugin = require "kong.plugins.base_plugin"
local MoleculerClient = require "kong.plugins.moleculer-bridge.moleculer"


local MoleculerBridge = BasePlugin:extend()

MoleculerBridge.VERSION  = "0.1.0-1"
MoleculerBridge.PRIORITY = 10


function MoleculerBridge:new()
  MoleculerBridge.super.new(self, "moleculer-bridge")
end

function MoleculerBridge:response(config)
  local client = MoleculerClient:new({
    node_id = 'lua-client', -- TODO: use dynamic value - hostname, configuration?
  })
  client:connect({
    host = 'nats',
    port = 4222,
  })

  local serialized = 'unknown';
  
  client:send(
    {
      node_id = 'one',
      action = 'test.hi',
      data = '{}',
    },
    function(response)
      serialized = json.encode(response)
    end
  )
  
  client.nats_client:wait(1)
  ngx.say(serialized)
end

return MoleculerBridge
