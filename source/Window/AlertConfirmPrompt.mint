component AlertConfirmPrompt {
  state infotext = ""

  fun alertSomething {
    await Window.alert("Hello World")
    next { infotext: "Hello World" }
  }

  fun confirmSomething {
    let choice =
      await Window.confirm("Want an apple?")

    let text =
      case choice {
        Result::Ok => "Nom Nom"
        Result::Err => "Not hungry"
      }

    next { infotext: text }
  }

  fun promptSomething {
    let words =
      await Window.prompt("You say:")

    let text =
      case words {
        Maybe::Just(value) => "You said: \"" + value + "\""
        Maybe::Nothing => "You chanceled"
      }

    next { infotext: text }
  }

  fun render {
    <section>
      <h3>"Alert, confirm, prompt"</h3>

      <p>
        <button onclick={alertSomething}>
          "Alert something"
        </button>

        " "

        <button onclick={confirmSomething}>
          "Confirm something"
        </button>

        " "

        <button onclick={promptSomething}>
          "Say something"
        </button>
      </p>

      <p>
        <{ infotext }>
      </p>
    </section>
  }
}
