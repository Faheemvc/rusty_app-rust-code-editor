# RustyApp

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


Check if Rust and Cargo are correctly installed on your system:
`rustc --version`
`cargo --version`

If they are not installed, install them using the official Rust installer:
`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`


Ensure Correct Rust Version
The Rustler library might require a specific version of Rust. You can ensure compatibility by using rustup to install the correct version of Rust:

`rustup install stable`
`rustup default stable`