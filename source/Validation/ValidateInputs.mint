component ValidateInputs {
  state email : String = ""
  state zip : String = ""
  state favnumber : String = ""
  state password1 : String = ""
  state password2 : String = ""
  state errors : Map(String, Array(String)) = Map.empty()

  fun componentDidMount {
    submit()

    Debug.log(
      Number.fromString("0b101010"))

    Debug.log(
      Validation.isNotBlank("0b101010", {"favnumber", "Plase enter a number."}))
  }

  fun submit {
    next
      {
        errors:
          Validation.merge(
            [
              Validation.isNotBlank(email, {"email", "Please enter your e-mail."}),
              Validation.isValidEmail(email, {"email", "Not a valid e-mail address."}),
              Validation.hasMinimumNumberOfCharacters(email, 7, {"email", "The e-mail too short."}),
              Validation.isNotBlank(zip, {"zip", "Please enter your zip code."}),
              Validation.isDigits(zip, {"zip", "The zip code can only contain digits."}),
              Validation.hasExactNumberOfCharacters(zip, 5, {"zip", "The zip code needs to have 5 digits."}),
              Validation.isNotBlank(favnumber, {"favnumber", "Please enter your favorite number."}),
              Validation.isNumber(favnumber, {"favnumber", "Please enter a number."}),
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
      "favnumber" => next { favnumber: value }
      "password1" => next { password1: value }
      "password2" => next { password2: value }
      => next { }
    }
  }

  fun showError (what : String) {
    <span>
      if let Maybe::Just(message) = Validation.getFirstError(errors, what) {
        <{ message }>
      }
    </span>
  }

  fun render {
    <section id="x">
      <h3>"Your data please"</h3>

      // action="/"
      <div onchange={update}>
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

          <label for="favnumber">
            "Fav Number:"
          </label>

          <input
            name="favnumber"
            type="text"
            placeholder="0b101010"
            value={favnumber}/>

          <{ showError("favnumber") }>

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

        // <input

        // name="submit"

        // type="submit"

        // value="Submit"

        // onclick={submit}/>
        <button onclick={submit}>
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