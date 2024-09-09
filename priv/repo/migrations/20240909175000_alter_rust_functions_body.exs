defmodule RustyApp.Repo.Migrations.AlterRustFunctionsBody do
  use Ecto.Migration

  def change do
    alter table(:rust_functions) do
      modify :body, :text
    end
  end
end
