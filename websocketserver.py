#!/usr/bin/env python

import asyncio
import json

# `pip install websockets`
import websockets
#  The websockets docs are also the source for this code.
# See https://websockets.readthedocs.io/en/stable/howto/quickstart.html#manage-application-state.
# I modified the code slightly, to also let the server indepently send messages to the clients, to denote the full duplex nature of Websockets.

USERS = set()
COUNTER = 0

async def broadcast(users, data, desc):
  if users:
    await asyncio.wait([
      asyncio.create_task(
        send(user, data, desc)
      ) for user in users
    ])

async def send(user, data, desc):
  await user.send(json.dumps({
    "data": data,
    "desc": desc
  }))

async def server_messages():
  # This is the place where we do serverside stuff and send messages to the connected clients, if needed.
  global COUNTER
  while True:
    await asyncio.sleep(2)
    COUNTER += 1
    await broadcast(USERS, COUNTER, "counter")

def user_messages():
  return websockets.serve(handle_connection, "localhost", PORT)

def parse(message):
  info = json.loads(message)
  return info["data"], info["desc"]

async def handle_connection(user):
  global USERS, COUNTER
  try:
    USERS.add(user)
    await broadcast(USERS, len(USERS), "amount_users")
    await send(user, COUNTER, "counter")
    async for message in user:
      # this is the place where we handle messages sent by a connected client. This is done indepently for each client.
      data, desc = parse(message)
      match desc:
        case "update_counter":
          COUNTER = COUNTER + data
          await broadcast(USERS, COUNTER, "counter")
        case other:
          print(f"unsupported: \"{desc}\": {data}")
  finally:
    USERS.remove(user)
    await broadcast(USERS, len(USERS), "amount_users")

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
