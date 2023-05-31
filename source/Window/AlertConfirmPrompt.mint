component AlertConfirmPrompt {
  state infoText = "Nothing clicked"

  fun alertSomething {
    await Window.alert("Hello World")
    next { infoText: "Hello World" }
  }

  fun confirmSomething {
    let choice =
      await Window.confirm("Want an apple?")

    let text =
      case choice {
        Result::Ok => "Nom Nom"
        Result::Err => "Not hungry"
      }

    next { infoText: text }
  }

  fun promptSomething {
    let words =
      await Window.prompt("You say:")

    let text =
      case words {
        Maybe::Just(value) => "You said: \"" + value + "\""
        Maybe::Nothing => "You canceled"
      }

    next { infoText: text }
  }

  fun render {
    <section>
      <h3>"Alert, confirm, prompt"</h3>

      <p>
        <button onClick={alertSomething}>
          "Alert something"
        </button>

        " "

        <button onClick={confirmSomething}>
          "Confirm something"
        </button>

        " "

        <button onClick={promptSomething}>
          "Say something"
        </button>
      </p>

      <p>
        <{ infoText }>
      </p>
    </section>
  }
}
