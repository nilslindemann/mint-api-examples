component Dimensions {

  state width = 0
  state height = 0
  state scrollWidth = 0
  state scrollHeight = 0
  state scrollLeft = 0
  state scrollTop = 0

  fun componentDidMount {
    Window.addEventListener("resize", true, updateListener)
    Window.addEventListener("scroll", true, updateListener)
    update()
  }

  fun updateListener (event: Html.Event) {
    update()
  }

  fun update() {
    next {
      width : Window.width(),
      height : Window.height(),
      scrollWidth : Window.scrollWidth(),
      scrollHeight : Window.scrollHeight(),
      scrollLeft : Window.scrollLeft(),
      scrollTop : Window.scrollTop(),
    }
  }

  fun info (title: String, value: Number) {
    <><{title}> ": " <{ value |> Number.toString() }> " px"</>
  }

  fun scroll(x: Number, y: Number) {
    Window.setScrollLeft(scrollLeft + x)
    Window.setScrollTop(scrollTop + y)
    update()
  }

  fun render {
    <section>
      <h3>"Dimensions"</h3>
      <p>
        <{info("Width", width)}> ", "
        <{info("height", height)}>
      </p>
      <p>
        <{info("Scroll width", scrollWidth)}> ", "
        <{info("scroll height", scrollHeight)}>
      </p>
      <p>
        <{info("Scroll left", scrollLeft)}> ", "
        <{info("scroll top", scrollTop)}>
      </p>
      <p>
        <button onclick={(){scroll(0, 1)}}>"Scroll bottom 1 px"</button>
        <button onclick={(){scroll(0, -1)}}>"Scroll top 1 px"</button>
        <button onclick={(){scroll(1, 0)}}>"Scroll right 1 px"</button>
        <button onclick={(){scroll(-1, 0)}}>"Scroll left 1 px"</button>
      </p>
      <p><small>
        "Hint: "
        <a href="https://askubuntu.com/a/307849">
          "To scroll left / right in Chrome"
        </a>
        ", open the Dev Tools (" <kbd>"F12"</kbd> ")."
      </small></p>
      <p>
        "Related: Scrollbar width: "
        <{ Window.getScrollbarWidth() |> Number.toString() }> "px."
      </p>
    </section>
  }
}
