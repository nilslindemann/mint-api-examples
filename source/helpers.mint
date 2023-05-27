component GoTop {
  fun gotop {
    Window.navigate("/")
    Window.triggerHashJump()
  }
  fun render {
    <p><a href="" onclick={gotop}>"Go top"</a></p>
  }
}