
local nats = require 'nats'
local json = require 'cjson'
local uuid = require 'uuid'

uuid.seed()

local MoleculerClient = {} 

function MoleculerClient:new (object)
  object = object or {}
  setmetatable(object, self)
  self.__index = self
  
  assert(object.node_id ~= nil and object.node_id ~= '', 'must specify node_id')
  self.node_id = object.node_id

  self.request_handlers = {}

  return object
end

-- TODO: Support some pluggable system; we only have NATS right now
-- Connect to the configured transport
function MoleculerClient:connect (options)
  self.nats_client = nats.connect(options)
  self.nats_client:connect()

  -- self check, let's declare we're really up and going
  self.nats_client:ping()

  -- setup subscription for responses
  local response_nats_subject = 'MOL.RES.' .. self.node_id
  self.nats_subscription_id = self.nats_client:subscribe(response_nats_subject, function(message)
    local packet = json.decode(message)
    local handler = self.request_handlers[packet.id]
   
    if handler ~= nil then
      handler(packet)
    end 
 end)
  
  print('Connected to NATS as ' .. self.node_id)
  print('Listening for responses on ' .. response_nats_subject)
end

function MoleculerClient:send (request, callback)
  assert(request.action ~= nil and request.action ~= '', 'action must be defined')

  local request_id = uuid()

  local subject = 'MOL.REQ.' .. request.node_id
  local payload = {
    ver = '4',
    sender = self.node_id,
    id = request_id,
    requestID = request_id,
    action = request.action,
  }

  self.request_handlers[request_id] = callback
  self.nats_client:publish(subject, json.encode(payload))
end

return MoleculerClient