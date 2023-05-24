enum A {
  Num(Number)
  Str(String)
  Bool(Bool)
}

component WindowTBD {

  fun row(name: String, value: A, unit: String = " px") {
    let val = case value {
      A::Num(value) => value |> Number.toString
      A::Bool(value) => value |> Bool.toString
      A::Str(value) => value
    }
    <tr>
      <td>
        <pre>
          <{name}>
        </pre>
      </td>
      <td>
        <{val}>
        <{unit}>
      </td>
    </tr>
  }

  fun render {
    <section>
      <h3>"To be done"</h3>
      <p><em>"Add examples for 'Dimensions', 'Scrolling'. Find good example for Window.matchesMediaQuery(), probably merge it with 'Listen to media query changes'"</em></p>
      <table>
        <tr>
          <td>
<pre>"Window.navigate(\"https://www.example.com\")\nWindow.open(\"https://www.google.com\")  // new window"</pre>
          </td>
          <td><em>"No examples yet"</em></td>
        </tr>

        <{ row("Window.width()", A::Num(Window.width())) }>
        <{ row("Window.height()", A::Num(Window.height())) }>
        <{ row("Window.scrollWidth()", A::Num(Window.scrollWidth())) }>
        <{ row("Window.scrollHeight()", A::Num(Window.scrollHeight())) }>
        <{ row("Window.scrollLeft()", A::Num(Window.scrollLeft())) }>
        <{ row("Window.scrollTop()", A::Num(Window.scrollTop())) }>
        <tr>
          <td>
<pre>"Window.setScrollLeft(0)\nWindow.setScrollTop(0)"</pre>
          </td>
          <td><em>"No examples yet"</em></td>
        </tr>

        <{ row("Window.getScrollbarWidth()", A::Num(Window.getScrollbarWidth())) }>
        <{ row("Window.matchesMediaQuery(\"(max-width: 1000px)\")", A::Bool(Window.matchesMediaQuery("(max-width: 1000px)")), "") }>

      </table>
    </section>
  }

}
