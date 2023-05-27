record Message {
  action : String,
  data : Number
}

component Websocket {

  state isReady = false
  state counter = 0
  state conns = 0
  state websocket = Maybe::Nothing

  fun componentDidMount {
    let ws = WebSocket.open({
      url: "ws://localhost:6789/",
      reconnectOnClose : true,
      onOpen : (w: WebSocket){ next {isReady: true} },
      onClose : (){ next {isReady: false} },
      onError : (){ next {isReady: false} },
      onMessage : (json: String) {
        let message = case Json.parse(json) {
          Result::Err => { action: "none", data: 0 }
          Result::Ok(object) =>
            case decode object as Message {
              Result::Err => { action: "none", data: 0 }
              Result::Ok(action) => action
            }
        }
        case message.action {
          "amount_conns" =>
            next { conns: message.data }
          "counter" =>
            next {counter: message.data}
          =>
            next {}
        }
      }
    })
    next {websocket: Maybe::Just(ws)}
  }

  fun addToCounter(num: Number) {
    case websocket {
      Maybe::Nothing =>
        next {counter: counter + num}
      Maybe::Just(ws) => {
        WebSocket.send(
          ws,
          (encode {
            action: "update_counter",
            data: num
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
            <{ conns |> Number.toString() }>
            " user"
            if conns == 1 { "" } else { "s" }
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
