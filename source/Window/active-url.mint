component ActiveUrl {

  fun check (url: String) {
    <tr>
      <td>
        <code><{ url }></code>
      </td>
      <td>
        <{ if Window.isActiveURL(url) {
          <green>"Yes"</green>
        } else {
          <red>"No"</red>
        } }>
      </td>
    </tr>
  }

  fun render : Html {
    <section>
      <h3>"Active URL?"</h3>
      <table>
        <{ check("http://127.0.0.1:3000/") }>
        <{ check("http://127.0.0.1:3000/?foo=bar") }>
        <{ check("http://127.0.0.1:3000/#lorem") }>
        <{ check("http://127.0.0.1:3000/a/b/c") }>
        <{ check("http://127.0.0.1:9999/") }>
        <{ check("http://999.9.9.9:3000/") }>
        <{ check("https://127.0.0.1:3000/") }>
      </table>
    </section>

  }
}