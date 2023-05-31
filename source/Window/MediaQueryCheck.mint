enum WinWidth {
  Unchecked
  Wide
  Narrow
}

component MediaQueryCheck {
  state isWide = WinWidth::Unchecked

  fun check {
    next
      {
        isWide:
          if Window.matchesMediaQuery("(max-width: 800px)") {
            WinWidth::Narrow
          } else {
            WinWidth::Wide
          }
      }
  }

  fun render {
    <section>
      <h4>"Check manually"</h4>

      <p>
        <button onClick={check}>
          "Check"
        </button>

        case isWide {
          WinWidth::Wide =>
            <>
              " The window is "

              <span class="ok">
                "more"
              </span>

              " than 800px wide"
            </>

          WinWidth::Narrow =>
            <>
              " The window is "

              <span class="error">
                "less"
              </span>

              " than 800px wide"
            </>

          =>
            <>""</>
        }
      </p>
    </section>
  }
}
