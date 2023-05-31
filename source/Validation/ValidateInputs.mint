component ValidateInputs {
  state email : String = ""
  state zip : String = ""
  state favNumber : String = ""
  state password1 : String = ""
  state password2 : String = ""
  state errors : Map(String, Array(String)) = Map.empty()

  fun componentDidMount {
    validate()
  }

  fun validate {
    next
      {
        errors:
          Validation.merge(
            [
              Validation.isNotBlank(email, {"email", "Please enter your e-mail."}),
              Validation.isValidEmail(email, {"email", "Not a valid e-mail address."}),
              Validation.hasMinimumNumberOfCharacters(email, 7, {"email", "The e-mail is too short."}),
              Validation.isNotBlank(zip, {"zip", "Please enter your zip code."}),
              Validation.isDigits(zip, {"zip", "The zip code can only contain digits."}),
              Validation.hasExactNumberOfCharacters(zip, 5, {"zip", "The zip code needs to have 5 digits."}),
              Validation.isNotBlank(favNumber, {"favNumber", "Please enter your favorite number."}),
              Validation.isNumber(favNumber, {"favNumber", "Please enter a number."}),
              Validation.isNotBlank(password1, {"password1", "Please enter your password."}),
              Validation.isNotBlank(password2, {"password1", "Please enter your password twice."}),
              Validation.isSame(password1, password2, {"password1", "The passwords do no match"}),
              Validation.hasMinimumNumberOfCharacters(password1, 3, {"password1", "The password is too short."})
            ])
      }
  }

  fun update (event : Html.Event) {
    let input =
      event.target

    let name =
      Dom.getAttribute(input, "name") or "?"

    let value =
      Dom.getValue(input)

    case name {
      "email" => next { email: value }
      "zip" => next { zip: value }
      "favNumber" => next { favNumber: value }
      "password1" => next { password1: value }
      "password2" => next { password2: value }
      => next { }
    }
  }

  fun showError (inputName : String) {
    <span>
      if let Maybe::Just(message) = Validation.getFirstError(errors, inputName) {
        <{ message }>
      }
    </span>
  }

  fun render {
      <h3>"Your data please"</h3>
    <section>

      // action="/"
      <div onChange={update}>
        <p class="grid3">
          <label for="email">
            "E-Mail:"
          </label>

          <input
            name="email"
            type="email"
            value={email}
            placeholder="you@example.com"/>

          <{ showError("email") }>

          <label for="zip">
            "Zip:"
          </label>

          <input
            name="zip"
            type="text"
            placeholder="12345"
            value={zip}/>

          <{ showError("zip") }>

          <label for="favNumber">
            "Fav Number:"
          </label>

          <input
            name="favNumber"
            type="text"
            placeholder="0b101010"
            value={favNumber}/>

          <{ showError("favNumber") }>

          <label for="password1">
            "Password:"
          </label>

          <input
            name="password1"
            type="password"
            placeholder=""
            value={password1}/>

          <{ showError("password1") }>

          <label for="password2">
            " Again: "
          </label>

          <input
            name="password2"
            type="password"
            placeholder=""
            value={password2}/>

          <span/>
        </p>

        <button onClick={validate}>
          "Submit"
        </button>
      </div>

      if Map.isEmpty(errors) {
        <p class="ok">
          "The form data is ok"
        </p>
      } else {
        <p class="error">
          "The form data is not ok"
        </p>
      }
    </section>
  }
}
