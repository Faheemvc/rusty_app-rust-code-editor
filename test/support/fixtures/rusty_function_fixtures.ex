defmodule RustyApp.RustyFunctionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RustyApp.RustyFunction` context.
  """

  @doc """
  Generate a rusty_functions.
  """
  def rusty_functions_fixture(attrs \\ %{}) do
    {:ok, rusty_functions} =
      attrs
      |> Enum.into(%{
        body: "some body",
        name: "some name",
        params: %{}
      })
      |> RustyApp.RustyFunction.create_rusty_functions()

    rusty_functions
  end
end
