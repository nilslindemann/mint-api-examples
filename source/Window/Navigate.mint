store AppState {

  state title = "nowhere"

  fun setTitle (newTitle: String) {
    next { title: newTitle }
  }
}

routes {
  /here {
    AppState.setTitle("here")
  }

  /there {
    AppState.setTitle("there")
  }
}

component Navigate {

  // https://mint-lang.com/guide/reference/components/connecting-stores
  connect AppState exposing { title, setTitle }

  fun update () {
    if title != "here" {
      Window.navigate("/here")
    } else {
      Window.navigate("/there")
    }
  }

  fun render {
    <section id="navigate">
        <h3>"We are #{title} " </h3>


        <p>
          <button onclick={update}>
            if title != "here" {"go here"} else {"go there"}
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