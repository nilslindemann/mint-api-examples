record TypedData {
  data : Number,
  desc : String
}

enum ServerMessage {
  Counter(Number)
  AmountUsers(Number)
  Unknown
}

component Websocket {
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
          (raw : String) {
            let message =
              parseServerMessage(raw)

            case message {
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

  fun parseServerMessage (raw : String) : ServerMessage {
    let Result::Ok(syntax) =
      Json.parse(raw) or return ServerMessage::Unknown

    let Result::Ok(semantic) =
      decode syntax as TypedData or return ServerMessage::Unknown

    case semantic.desc {
      "counter" => ServerMessage::Counter(semantic.data)
      "amount_users" => ServerMessage::AmountUsers(semantic.data)
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
    <section id="websocket">
      <h2>"WebSocket"</h2>

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

      <GoTop/>
    </section>
  }
}
