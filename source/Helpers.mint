component GoTop {
  fun render {
    <p>
      <a
        href="/"
        onClick={
          (event : Html.Event) {
            Html.Event.preventDefault(event)
            Window.navigate("/")
            Window.triggerHashJump()
          }
        }>

        "Go top"

      </a>
    </p>
  }
}
