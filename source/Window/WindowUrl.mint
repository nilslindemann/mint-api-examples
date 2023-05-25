component WindowUrl {

  state url = Window.url()
  // There is also `Window.href()` which returns the url as string

  fun goto (hash: String) {
    Window.navigate( hash )
    Window.triggerHashJump()
    next { url: Window.url() }
  }

  fun render : Html {
    <section id="this-windows-url">
      <h3>"This window's URL"</h3>
      <p><{url |> Url.toString()}></p>
      <p>
        <button onclick={(){goto("/#this-windows-url")}}>"Focus"</button>
        <button onclick={(){goto("/")}}>"Go top"</button>
      </p>
    </section>

  }
}