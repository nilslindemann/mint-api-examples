component MediaQueryListener {
  state windowIsWide = false

  fun componentDidMount {
    Window.addMediaQueryListener(
      "(max-width: 800px)",
      (matches : Bool) {
        next { windowIsWide: !matches }
      })
  }

  fun render {
    <section>
      <h3>"Listen to media query changes"</h3>

      if windowIsWide {
        <p>
          "The window is "

          <span class="green">
            "more"
          </span>

          " than 800px wide"
        </p>
      } else {
        <p>
          "The window is "

          <span class="red">
            "less"
          </span>

          " than 800px wide"
        </p>
      }

      <MediaQueryCheck/>
    </section>
  }
}
