defmodule RustyApp.RustyFunction.RustyFunctions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rust_functions" do
    field :name, :string
    field :params, :map
    field :body, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(rusty_functions, attrs) do
    rusty_functions
    |> cast(attrs, [:name, :body, :params])
    |> validate_required([:name, :body])
  end
end
