component ActiveUrl {
  state urlInfos =
    [
      {"http://127.0.0.1:3000/", false},
      {"http://127.0.0.1:3000/?foo=bar", false},
      {"http://127.0.0.1:3000/#lorem", false},
      {"http://127.0.0.1:3000/a/b/c", false},
      {"http://127.0.0.1:9999/", false},
      {"http://999.9.9.9:3000/", false},
      {"https://127.0.0.1:3000/", false}
    ]

  use Provider.Url {
    changes:
      (url : Url) : Promise(Void) {
        check(url)
      }
  }

  fun componentDidMount {
    check(Window.url())
  }

  fun check (url : Url) : Promise(Void) {
    next
      {
        urlInfos:
          for urlInfo of urlInfos {
            let url =
              urlInfo[0]

            {url, Window.isActiveURL(url)}
          }
      }
  }

  fun rows (urlInfos : Array(Tuple(String, Bool))) {
    for urlInfo of urlInfos {
      let {url, isActiveUrl} =
        urlInfo

      <tr>
        <td>
          <code>
            <{ url }>
          </code>
        </td>

        <td>
          <{
            if isActiveUrl {
              <span class="ok">
                "Yes"
              </span>
            } else {
              <span class="error">
                "No"
              </span>
            }
          }>
        </td>
      </tr>
    }
  }

  fun render : Html {
    <section>
      <h3>"Active URL?"</h3>

      <table>
        <{ rows(urlInfos) }>
      </table>
    </section>
  }
}
