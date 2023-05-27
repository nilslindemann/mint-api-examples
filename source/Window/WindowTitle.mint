component WindowTitle {
  state title = Window.title()
  state input = Maybe::Nothing

  fun componentDidMount {
    next { input: Dom.getElementById("title-entry") }
  }

  fun update (event : Html.Event) {
    Window.setTitle(Dom.getValue(event.target))
  }

  fun reset {
    Window.setTitle(title)

    case input {
      Maybe::Nothing => { }

      Maybe::Just(element) =>
        {
          Dom.setValue(element, title)
          { }
        }
    }
  }

  fun render : Html {
    <section>
      <h3>"Read / Set window title"</h3>
      <p>"(See the text in the window tab)"</p>

      <p>
        <input
          id="title-entry"
          value={title}
          onChange={update}
          type="text"/>

        " "

        <button onclick={reset}>
          "Reset"
        </button>
      </p>
    </section>
  }
}
