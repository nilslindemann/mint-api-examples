component WindowUrl {
  state url = Window.url()

  fun setUrlTo (url : String) {
    Window.setUrl(url)
    next { url: Window.url() }
  }

  fun navigateTo (url : String) {
    Window.navigate(url)
    next { url: Window.url() }
  }

  fun jumpTo (url : String) {
    Window.navigate(url)
    Window.triggerHashJump()
    next { url: Window.url() }
  }

  fun render : Html {
    <section id="here">
      <h3>"This window's URL"</h3>

      // Alternatively use `Window.href()`.
      <p>
        <{
          url
          |> Url.toString()
        }>
      </p>

      <div class="grid4">
        <span>"Set URL to"</span>

        <button onClick={() { setUrlTo("#here") }}>
          "#here"
        </button>

        <button onClick={() { setUrlTo("/") }}>
          "/"
        </button>

        <button onClick={() { setUrlTo("/a/b/c") }}>
          "/a/b/c"
        </button>

        <span>"Also update navigation history"</span>

        <button onClick={() { navigateTo("#here") }}>
          "#here"
        </button>

        <button onClick={() { navigateTo("/") }}>
          "/"
        </button>

        <button onClick={() { navigateTo("/a/b/c") }}>
          "/a/b/c"
        </button>

        <span>"Also jump there"</span>

        <button onClick={() { jumpTo("#here") }}>
          "#here"
        </button>

        <button onClick={() { jumpTo("/") }}>
          "/"
        </button>

        <button onClick={() { jumpTo("/a/b/c") }}>
          "/a/b/c"
        </button>
      </div>
    </section>
  }
}
