# Kong Moleculer Bridge

Proof of concept for using [Moleculer](https://github.com/moleculer/moleculerjs) with [Kong](https://konghq.com).

This module implements the request packet (non-balanced) of Moleculer over the NATS transport. The approach of using a plugin for _generating_ responses is not optimal and -after experimenting here- should be handled later in the stack.

## Module

Dependencies:

- `lua-cjson`
  - At least `2.1.0-1`- the one bundled with Kong is ok
- `uuid`
- `nats` https://github.com/dawnangel/lua-nats
