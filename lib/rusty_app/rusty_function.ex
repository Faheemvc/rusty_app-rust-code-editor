defmodule RustyApp.RustyFunction do
  @moduledoc """
  The RustyFunction context.
  """

  import Ecto.Query, warn: false
  alias RustyApp.Repo

  alias RustyApp.RustyFunction.RustyFunctions

  @doc """
  Returns the list of rust_functions.

  ## Examples

      iex> list_rust_functions()
      [%RustyFunctions{}, ...]

  """
  def list_rust_functions do
    Repo.all(RustyFunctions, select: [:id, :name, :params, :body])
  end

  @doc """
  Gets a single rusty_functions.

  Raises `Ecto.NoResultsError` if the Rusty functions does not exist.

  ## Examples

      iex> get_rusty_functions!(123)
      %RustyFunctions{}

      iex> get_rusty_functions!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rusty_functions!(id), do: Repo.get!(RustyFunctions, id)

  @doc """
  Creates a rusty_functions.

  ## Examples

      iex> create_rusty_functions(%{field: value})
      {:ok, %RustyFunctions{}}

      iex> create_rusty_functions(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rusty_functions(attrs \\ %{}) do
    %RustyFunctions{}
    |> RustyFunctions.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rusty_functions.

  ## Examples

      iex> update_rusty_functions(rusty_functions, %{field: new_value})
      {:ok, %RustyFunctions{}}

      iex> update_rusty_functions(rusty_functions, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rusty_functions(%RustyFunctions{} = rusty_functions, attrs) do
    rusty_functions
    |> RustyFunctions.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rusty_functions.

  ## Examples

      iex> delete_rusty_functions(rusty_functions)
      {:ok, %RustyFunctions{}}

      iex> delete_rusty_functions(rusty_functions)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rusty_functions(%RustyFunctions{} = rusty_functions) do
    Repo.delete(rusty_functions)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rusty_functions changes.

  ## Examples

      iex> change_rusty_functions(rusty_functions)
      %Ecto.Changeset{data: %RustyFunctions{}}

  """
  def change_rusty_functions(%RustyFunctions{} = rusty_functions, attrs \\ %{}) do
    RustyFunctions.changeset(rusty_functions, attrs)
  end
end
