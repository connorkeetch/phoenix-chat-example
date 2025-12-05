defmodule ChatWeb.AuthControllerTest do
  use ChatWeb.ConnCase, async: true

  test "login redirects to home and sets session", %{conn: conn} do
    conn = get(conn, "/login")
    assert redirected_to(conn, 302) == "/"
    assert get_session(conn, :user)
  end

  test "logout redirects to home and clears session", %{conn: conn} do
    conn =
      conn
      |> init_test_session(%{user: %{name: "Test"}})
      |> get("/logout")

    assert redirected_to(conn, 302) == "/"
    refute get_session(conn, :user)
  end
end
