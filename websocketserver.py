#!/usr/bin/env python

import asyncio
import json

# `pip install websockets`
import websockets
#  The websockets docs are also the source for this code.
# See https://websockets.readthedocs.io/en/stable/howto/quickstart.html#manage-application-state.
# I modified the code slightly, to also let the server indepently send messages to the clients, to denote the full duplex nature of Websockets.

CONNS = set()
COUNTER = 0

async def broadcast(conns, action, data):
  if conns:
    await asyncio.wait([
      asyncio.create_task(
        send(conn, action, data)
      ) for conn in conns
    ])

async def send(conn, action, data):
  await conn.send(json.dumps({
    "action": action,
    "data": data
  }))

async def server_messages():
  # This is the place where we do serverside stuff and send messages to the connected clients, if needed.
  global COUNTER
  while True:
    await asyncio.sleep(2)
    COUNTER += 1
    await broadcast(CONNS, "counter", COUNTER)

def user_messages():
  return websockets.serve(handle_connection, "localhost", PORT)

def parse(raw_message):
  message = json.loads(raw_message)
  return message["action"], message["data"]

async def handle_connection(conn):
  global CONNS, COUNTER
  try:
    CONNS.add(conn)
    await broadcast(CONNS, "amount_conns", len(CONNS))
    await send(conn, "counter", COUNTER)
    async for message in conn:
      # this is the place where we handle messages sent by a connected client. This is done indepently for each client.
      action, data = parse(message)
      match action:
        case "update_counter":
          COUNTER = COUNTER + data
          await broadcast(CONNS, "counter", COUNTER)
        case other:
          print(f"unsupported action: {{{action}: {data}}}")
  finally:
    CONNS.remove(conn)
    await broadcast(CONNS, "amount_conns", len(CONNS))

PORT = 6789

async def main():
  await asyncio.gather(
    server_messages(),
    user_messages()
  )

if __name__ == "__main__":
  print(f'Listening on ws://localhost:{PORT}/')
  try:
    asyncio.run(main())
  except KeyboardInterrupt:
    print("\nbye")
