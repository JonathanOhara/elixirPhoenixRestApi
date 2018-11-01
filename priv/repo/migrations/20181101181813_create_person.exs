defmodule HelloElixir.Repo.Migrations.CreatePerson do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :name, :string
      add :age, :integer
      add :email, :string
      timestamps()
    end
    create unique_index(:persons, [:email])
  end
end
