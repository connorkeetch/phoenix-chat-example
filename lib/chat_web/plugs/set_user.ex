defmodule ChatWeb.Plugs.SetUser do
  import Plug.Conn

  def init(_params), do: nil

  def call(conn, _params) do
    user = get_session(conn, :user)

    if user do
      conn
      |> assign(:loggedin, true)
      |> assign(:person, user)
    else
      conn
      |> assign(:loggedin, false)
      |> assign(:person, nil)
    end
  end
end
