# Moleculer Lua

Proof of concept for using [Moleculer](https://github.com/moleculer/moleculerjs) with Lua.

This only implements the request packet (non-balanced) of Moleculer over the NATS transport.

## Usage

Dependencies:

- `lua-cjson 2.1.0-1`
- `uuid`
- `nats` https://github.com/dawnangel/lua-nats
