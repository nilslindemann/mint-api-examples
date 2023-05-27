record ServerMessage {
  data : Number,
  desc : String
}

component Websocket {

  state isReady = false
  state counter = 0
  state amountUsers = 0
  state connection = Maybe::Nothing

  fun componentDidMount {
    let websocket = createWebsocket()
    next { connection: Maybe::Just(websocket) }
  }

  fun createWebsocket() {
    WebSocket.open({
      url: "ws://localhost:6789/",
      reconnectOnClose : true,
      onOpen : (w: WebSocket){ next {isReady: true} },
      onClose : (){ next {isReady: false} },
      onError : (){ next {isReady: false} },
      onMessage : (raw: String) {
        let message = parseServerMessage(raw)
        case message.desc {
          "amount_users" =>
            next { amountUsers: message.data }
          "counter" =>
            next {counter: message.data}
          =>
            next {}
        }
      }
    })
  }

  fun parseServerMessage(raw: String): ServerMessage {
    case Json.parse(raw) {
      Result::Err => unknownMessage()
      Result::Ok(object) =>
        case decode object as ServerMessage {
          Result::Err => unknownMessage()
          Result::Ok(parsed) => parsed
        }
    }
  }

  fun unknownMessage {
    { data: 0, desc: "unknown" }
  }

  fun addToCounter(num: Number) {
    case connection {
      Maybe::Nothing =>
        next {counter: counter + num}
      Maybe::Just(websocket) => {
        WebSocket.send(
          websocket,
          (encode {
            data: num,
            desc: "update_counter"
          }) |> Json.stringify()
        )
        next {}
      }
    }
  }

  fun render {
    <section id="websocket">
      <h2>"WebSocket"</h2>
      if isReady {
        <>
          <div class="grid3">
            <button onclick={(){addToCounter(-1)}}>"-"</button>
            <span> <{ counter |> Number.toString() }> </span>
            <button onclick={(){addToCounter(1)}}>"+"</button>
          </div>
          <p>
            <{ amountUsers |> Number.toString() }>
            " user"
            if amountUsers == 1 { "" } else { "s" }
            " online"
          </p>
        </>
      } else {
        <p class="important">
          "Can not establish a websocket connection. is " <code>"websocketserver.py"</code>
          " running?"
        </p>
      }
      <GoTop/>
    </section>
  }
}
