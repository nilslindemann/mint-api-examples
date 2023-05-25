enum WinWidth { Unchecked Wide Narrow }

component MediaQueryCheck {

  state isWide = WinWidth::Unchecked

  fun check () {
    next {
      isWide: if Window.matchesMediaQuery("(max-width: 800px)") {
        WinWidth::Narrow
      } else {
        WinWidth::Wide
      }
    }
  }

  fun render {
    <section>
      <h3>"Check media query manually"</h3>
      <p>
        <button onclick={check}>"Check"</button>
        case isWide {
          WinWidth::Wide =>
            <> " The window is " <green>"more"</green> " than 800px wide" </>
          WinWidth::Narrow =>
            <> " The window is " <red>"less"</red> " than 800px wide" </>
          =>
            <> "" </>
        }
      </p>
    </section>
  }

}
