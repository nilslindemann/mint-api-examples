component WindowUrl {
  state url = Window.url()

  fun seturlto (url : String) {
    Window.setUrl(url)
    next { url: Window.url() }
  }

  fun navigateto (url : String) {
    Window.navigate(url)
    next { url: Window.url() }
  }

  fun jumpto (url : String) {
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

        <button onclick={() { seturlto("#here") }}>
          "#here"
        </button>

        <button onclick={() { seturlto("/") }}>
          "/"
        </button>

        <button onclick={() { seturlto("/a/b/c") }}>
          "/a/b/c"
        </button>

        <span>"Also update navigation history"</span>

        <button onclick={() { navigateto("#here") }}>
          "#here"
        </button>

        <button onclick={() { navigateto("/") }}>
          "/"
        </button>

        <button onclick={() { navigateto("/a/b/c") }}>
          "/a/b/c"
        </button>

        <span>"Also jump there"</span>

        <button onclick={() { jumpto("#here") }}>
          "#here"
        </button>

        <button onclick={() { jumpto("/") }}>
          "/"
        </button>

        <button onclick={() { jumpto("/a/b/c") }}>
          "/a/b/c"
        </button>
      </div>
    </section>
  }
}
