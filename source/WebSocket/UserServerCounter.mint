record TypedData {
  data : Number,
  desc : String
}

enum ServerMessage {
  Counter(Number)
  AmountUsers(Number)
  Unknown
}

component UserServerCounter {
  state isReady = false
  state counter = 0
  state amountUsers = 0
  state connection = Maybe::Nothing

  fun componentDidMount {
    let websocket =
      createWebsocket()

    next { connection: Maybe::Just(websocket) }
  }

  fun createWebsocket {
    WebSocket.open(
      {
        url: "ws://localhost:6789/",
        reconnectOnClose: true,
        onOpen: (w : WebSocket) { next { isReady: true } },
        onClose: () { next { isReady: false } },
        onError: () { next { isReady: false } },
        onMessage:
          (message : String) {
            case parseMessage(message) {
              ServerMessage::AmountUsers(a) =>
                next { amountUsers: a }

              ServerMessage::Counter(c) =>
                next { counter: c }

              =>
                next { }
            }
          }
      })
  }

  fun parseMessage (message : String) : ServerMessage {
    let Result::Ok(message) =
      Json.parse(message) or return ServerMessage::Unknown

    let Result::Ok(message) =
      decode message as TypedData or return ServerMessage::Unknown

    case message.desc {
      "counter" => ServerMessage::Counter(message.data)
      "amount_users" => ServerMessage::AmountUsers(message.data)
      => ServerMessage::Unknown
    }
  }

  fun send (websocket : WebSocket, data : Number, desc : String) {
    WebSocket.send(
      websocket,
      (encode {
        data: data,
        desc: desc
      })
      |> Json.stringify())
  }

  fun addToCounter (num : Number) {
    case connection {
      Maybe::Nothing =>
        next { counter: counter + num }

      Maybe::Just(websocket) =>
        send(websocket, num, "update_counter")
    }
  }

  fun render {
    <section id="user-server-counter">
      <h3>"User-Server-counter"</h3>

      if isReady {
        <>
          <div class="grid3">
            <button onclick={() { addToCounter(-1) }}>
              "-"
            </button>

            <span>
              <{
                counter
                |> Number.toString()
              }>
            </span>

            <button onclick={() { addToCounter(1) }}>
              "+"
            </button>
          </div>

          <p>
            <{
              amountUsers
              |> Number.toString()
            }>

            " user"

            if amountUsers == 1 {
              ""
            } else {
              "s"
            }

            " online"
          </p>
        </>
      } else {
        <p class="important">
          "Can not establish a websocket connection. is "
          <code>"websocketserver.py"</code>
          " running?"
        </p>
      }
    </section>
  }
}
