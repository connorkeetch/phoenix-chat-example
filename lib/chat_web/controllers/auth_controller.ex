defmodule ChatWeb.AuthController do
  use ChatWeb, :controller

  def login(conn, _params) do
    user = %{
      givenName: "Guest",
      name: "Guest " <> Integer.to_string(Enum.random(1000..9999)),
      picture: "https://www.gravatar.com/avatar/?d=identicon"
    }

    conn
    |> put_session(:user, user)
    |> redirect(to: "/")
  end

  def logout(conn, _params) do
    conn
    |> delete_session(:user)
    |> redirect(to: "/")
  end
end
