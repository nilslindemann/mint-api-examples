store AppState {

  state title = ""

  fun setTitle (newTitle: String) {
    next { title: newTitle }
  }
}

routes {
  / {
    AppState.setTitle("here")
  }

  /there {
    AppState.setTitle("there")
  }
}

component Navigate {

  // https://mint-lang.com/guide/reference/components/connecting-stores
  connect AppState exposing { title, setTitle }

  fun componentDidMount () {
    Window.navigate("/")
  }

  fun update () {
    if title == "here" {
      Window.navigate("/there")
    } else {
      Window.navigate("/")
    }
  }

  fun render {
    <section id="navigate">
        <h3>"We are #{title} " </h3>


        <p>
          <button onclick={update}>
            if title == "here" {"go there"} else {"go back"}
          </button>
          " (Internal)"
        </p>

        <p>
          <button
          onclick={(){Window.open("https://mint-lang.com/")}}>
            "Mint Homepage"
          </button>
          " (External)"
        </p>

    </section>
  }
}