local typedefs = require "kong.db.schema.typedefs"

return {
  name = "moleculer-bridge",
  fields = {
    {
      -- Plugin will only be applied to Service/Route
      consumer = typedefs.no_consumer
    },
    {
      protocols = typedefs.protocols_http
    },
    {
      config = {
        type = "record",
        fields = {},
      },
    },
  },
  entity_checks = {
  },
}