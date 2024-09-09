defmodule RustyApp.Repo.Migrations.CreateRustFunctions do
  use Ecto.Migration

  def change do
    create table(:rust_functions) do
      add :name, :string
      add :body, :string
      add :params, :map

      timestamps(type: :utc_datetime)
    end
  end
end
