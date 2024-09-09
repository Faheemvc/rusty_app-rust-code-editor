defmodule RustyApp.RustyFunctionTest do
  use RustyApp.DataCase

  alias RustyApp.RustyFunction

  describe "rust_functions" do
    alias RustyApp.RustyFunction.RustyFunctions

    import RustyApp.RustyFunctionFixtures

    @invalid_attrs %{name: nil, params: nil, body: nil}

    test "list_rust_functions/0 returns all rust_functions" do
      rusty_functions = rusty_functions_fixture()
      assert RustyFunction.list_rust_functions() == [rusty_functions]
    end

    test "get_rusty_functions!/1 returns the rusty_functions with given id" do
      rusty_functions = rusty_functions_fixture()
      assert RustyFunction.get_rusty_functions!(rusty_functions.id) == rusty_functions
    end

    test "create_rusty_functions/1 with valid data creates a rusty_functions" do
      valid_attrs = %{name: "some name", params: %{}, body: "some body"}

      assert {:ok, %RustyFunctions{} = rusty_functions} = RustyFunction.create_rusty_functions(valid_attrs)
      assert rusty_functions.name == "some name"
      assert rusty_functions.params == %{}
      assert rusty_functions.body == "some body"
    end

    test "create_rusty_functions/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RustyFunction.create_rusty_functions(@invalid_attrs)
    end

    test "update_rusty_functions/2 with valid data updates the rusty_functions" do
      rusty_functions = rusty_functions_fixture()
      update_attrs = %{name: "some updated name", params: %{}, body: "some updated body"}

      assert {:ok, %RustyFunctions{} = rusty_functions} = RustyFunction.update_rusty_functions(rusty_functions, update_attrs)
      assert rusty_functions.name == "some updated name"
      assert rusty_functions.params == %{}
      assert rusty_functions.body == "some updated body"
    end

    test "update_rusty_functions/2 with invalid data returns error changeset" do
      rusty_functions = rusty_functions_fixture()
      assert {:error, %Ecto.Changeset{}} = RustyFunction.update_rusty_functions(rusty_functions, @invalid_attrs)
      assert rusty_functions == RustyFunction.get_rusty_functions!(rusty_functions.id)
    end

    test "delete_rusty_functions/1 deletes the rusty_functions" do
      rusty_functions = rusty_functions_fixture()
      assert {:ok, %RustyFunctions{}} = RustyFunction.delete_rusty_functions(rusty_functions)
      assert_raise Ecto.NoResultsError, fn -> RustyFunction.get_rusty_functions!(rusty_functions.id) end
    end

    test "change_rusty_functions/1 returns a rusty_functions changeset" do
      rusty_functions = rusty_functions_fixture()
      assert %Ecto.Changeset{} = RustyFunction.change_rusty_functions(rusty_functions)
    end
  end
end
