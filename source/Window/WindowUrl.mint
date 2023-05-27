component WindowUrl {

  state url = Window.url()

  fun seturlto (url: String) {
    Window.setUrl( url )
    next { url: Window.url() }
  }

  fun navigateto (url: String) {
    Window.navigate( url )
    next { url: Window.url() }
  }

  fun jumpto (url: String) {
    Window.navigate( url )
    Window.triggerHashJump()
    next { url: Window.url() }
  }

  fun render : Html {
    <section id="here">
      <h3>"This window's URL"</h3>

      // Alternatively use `Window.href()`.
      <p><{url |> Url.toString()}></p>

      <div class="grid3">
        <span>"Set URL to"</span>
        <button onclick={(){ seturlto("#here") }}>"#here"</button>
        <button onclick={(){ seturlto("/") }}>"/"</button>

        <span>"Also update navigation history"</span>
        <button onclick={(){ navigateto("#here") }}>"#here"</button>
        <button onclick={(){ navigateto("/") }}>"/"</button>

        <span>"Also jump there"</span>
        <button onclick={(){ jumpto("#here") }}>"#here"</button>
        <button onclick={(){ jumpto("/") }}>"/"</button>
      </div>
    </section>

  }
}