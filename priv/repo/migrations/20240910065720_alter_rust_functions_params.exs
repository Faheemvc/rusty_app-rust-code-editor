defmodule RustyApp.Repo.Migrations.AlterRustFunctionsParams do
  use Ecto.Migration

  def change do
    alter table(:rust_functions) do
      modify :params, :string
    end
  end
end
