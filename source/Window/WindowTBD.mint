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
      <table>
        <tr>
          <td>
<pre>"Window.navigate(\"https://www.example.com\")\nWindow.open(\"https://www.google.com\")  // new window"</pre>
          </td>
          <td><em>"No examples yet"</em></td>
        </tr>

        <{ row("Window.getScrollbarWidth()", A::Num(Window.getScrollbarWidth())) }>

      </table>
    </section>
  }

}
