component WindowUrl {

  state url = Window.url()
  state rawUrl = Window.href()

  fun urlToString(url: Url, setHash: String = ""): String {
    url.origin +
    url.path +
    url.search +
    case setHash {
      "" => url.hash
      "-" => ""
      => setHash
    }
  }

  fun goto (hash: String) {
    let newUrl = urlToString(url, hash)
    Window.navigate( newUrl )
    Window.triggerHashJump()
    next { rawUrl: newUrl }
  }

  use Provider.Url {
    changes: (url: Url) : Promise(Void) {
      next { rawUrl: urlToString(url) }
    }
  }

  fun render : Html {
    <section id="this-windows-url">
      <h3>"This window's URL"</h3>
      <p><{rawUrl}></p>
      <p>
        <button onclick={(){goto("#this-windows-url")}}>"Focus"</button>
        <button onclick={(){goto("-")}}>"Remove hash"</button>
        <button onclick={(){goto("#top")}}>"Go top"</button>
      </p>
    </section>

  }
}