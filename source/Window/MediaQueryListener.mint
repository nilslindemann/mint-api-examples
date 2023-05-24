component MediaQueryListener {

  state windowIsWide = false

  fun componentDidMount {

    Window.addMediaQueryListener("(max-width: 800px)", (matches: Bool) {
      next {windowIsWide: !matches}
    })
  }

  fun render {
    <section>
      <h3>"Listen to media query changes"</h3>
      if windowIsWide {
        <p>
          "The window is " <green>"more"</green> " than 800px wide"
        </p>
      } else {
        <p>
          "The window is " <red>"less"</red> " than 800px wide"
        </p>
      }
    </section>
  }

}
