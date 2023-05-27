component PlayWithUrl {
  state input = Maybe::Nothing
  state href = ""
  state url = Window.url()

  fun componentDidMount {
    next { input: Dom.getElementById("url-entry") }
    reset()
  }

  fun reset {
    update("http://helloworld.com:3000/path?search=foo#hash")
  }

  fun changed (event : Html.Event) {
    update(
      Dom.getValue(event.target))
  }

  fun update (newHref : String) {
    let newUrl =
      Url.parse(newHref)

    next
      {
        href: newHref,
        url: newUrl
      }
  }

  fun render : Html {
    <section>
      <h3>"Play with an URL"</h3>

      <p>
        <label>"URL: "</label>

        <input
          type="text"
          id="url-entry"
          style="width: calc(100% - 8em);"
          value={href}
          onChange={changed}/>

        " "

        <button onclick={reset}>
          "Reset"
        </button>
      </p>

      <dl>
        <dt>"Origin"</dt>

        <dd>
          <{ url.origin }>
        </dd>

        <dt>"Protocol"</dt>

        <dd>
          <{ url.protocol }>
        </dd>

        <dt>"Host"</dt>

        <dd>
          <{ url.host }>
        </dd>

        <dt>"Hostname"</dt>

        <dd>
          <{ url.hostname }>
        </dd>

        <dt>"Port"</dt>

        <dd>
          <{ url.port }>
        </dd>

        <dt>"Path"</dt>

        <dd>
          <{ url.path }>
        </dd>

        <dt>"Search"</dt>

        <dd>
          <{ url.search }>
        </dd>

        <dt>"Hash"</dt>

        <dd>
          <{ url.hash }>
        </dd>
      </dl>
    </section>
  }
}
