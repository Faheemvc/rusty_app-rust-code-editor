defmodule RustyAppWeb.RustyFunctionsLiveTest do
  use RustyAppWeb.ConnCase

  import Phoenix.LiveViewTest
  import RustyApp.RustyFunctionFixtures

  @create_attrs %{name: "some name", params: %{}, body: "some body"}
  @update_attrs %{name: "some updated name", params: %{}, body: "some updated body"}
  @invalid_attrs %{name: nil, params: nil, body: nil}

  defp create_rusty_functions(_) do
    rusty_functions = rusty_functions_fixture()
    %{rusty_functions: rusty_functions}
  end

  describe "Index" do
    setup [:create_rusty_functions]

    test "lists all rust_functions", %{conn: conn, rusty_functions: rusty_functions} do
      {:ok, _index_live, html} = live(conn, ~p"/rust_functions")

      assert html =~ "Listing Rust functions"
      assert html =~ rusty_functions.name
    end

    test "saves new rusty_functions", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/rust_functions")

      assert index_live |> element("a", "New Rusty functions") |> render_click() =~
               "New Rusty functions"

      assert_patch(index_live, ~p"/rust_functions/new")

      assert index_live
             |> form("#rusty_functions-form", rusty_functions: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#rusty_functions-form", rusty_functions: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/rust_functions")

      html = render(index_live)
      assert html =~ "Rusty functions created successfully"
      assert html =~ "some name"
    end

    test "updates rusty_functions in listing", %{conn: conn, rusty_functions: rusty_functions} do
      {:ok, index_live, _html} = live(conn, ~p"/rust_functions")

      assert index_live |> element("#rust_functions-#{rusty_functions.id} a", "Edit") |> render_click() =~
               "Edit Rusty functions"

      assert_patch(index_live, ~p"/rust_functions/#{rusty_functions}/edit")

      assert index_live
             |> form("#rusty_functions-form", rusty_functions: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#rusty_functions-form", rusty_functions: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/rust_functions")

      html = render(index_live)
      assert html =~ "Rusty functions updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes rusty_functions in listing", %{conn: conn, rusty_functions: rusty_functions} do
      {:ok, index_live, _html} = live(conn, ~p"/rust_functions")

      assert index_live |> element("#rust_functions-#{rusty_functions.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rust_functions-#{rusty_functions.id}")
    end
  end

  describe "Show" do
    setup [:create_rusty_functions]

    test "displays rusty_functions", %{conn: conn, rusty_functions: rusty_functions} do
      {:ok, _show_live, html} = live(conn, ~p"/rust_functions/#{rusty_functions}")

      assert html =~ "Show Rusty functions"
      assert html =~ rusty_functions.name
    end

    test "updates rusty_functions within modal", %{conn: conn, rusty_functions: rusty_functions} do
      {:ok, show_live, _html} = live(conn, ~p"/rust_functions/#{rusty_functions}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rusty functions"

      assert_patch(show_live, ~p"/rust_functions/#{rusty_functions}/show/edit")

      assert show_live
             |> form("#rusty_functions-form", rusty_functions: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#rusty_functions-form", rusty_functions: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/rust_functions/#{rusty_functions}")

      html = render(show_live)
      assert html =~ "Rusty functions updated successfully"
      assert html =~ "some updated name"
    end
  end
end
