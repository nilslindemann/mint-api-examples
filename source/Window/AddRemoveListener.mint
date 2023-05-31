component AddRemoveListener {
  state handlerRemover : Maybe(Function(Void)) = Maybe::Nothing
  state buttonText = "Add a window click listener"
  state clickAmount = 0

  fun toggleHandler {
    case handlerRemover {
      Maybe::Nothing =>
        {
          // TBD: Why cant I give the type `Function(Void)` to `remover`?
          let remover =
            Window.addEventListener(
              "click",
              true,
              (event : Html.Event) {
                next { clickAmount: clickAmount + 1 }
              })

          next
            {
              handlerRemover: Maybe::Just(remover),
              buttonText: "Remove the window click listener"
            }
        }

      Maybe::Just(remover) =>
        {
          remover()

          next
            {
              handlerRemover: Maybe::Nothing,
              buttonText: "Add a window click listener"
            }
        }
    }
  }

  fun render {
    <section>
      <h3>"Add / Remove listener"</h3>

      <button onClick={toggleHandler}>
        <{ buttonText }>
      </button>

      <p>
        "The window was clicked #{clickAmount
        |> Number.toString} times"
      </p>
    </section>
  }
}
