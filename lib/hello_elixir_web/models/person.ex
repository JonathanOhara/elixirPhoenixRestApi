defmodule HelloElixirWeb.Person do
  use HelloElixirWeb, :model

    schema "persons" do
      field :name, :string
      field :age, :integer
      field :email, :string

      timestamps()
  end

  def changeset(person, params \\ :empty) do
    person
      |> cast(params, [:name, :email, :age])
      |> validate_required([:name, :email])
      |> validate_format(:email, ~r/@/)
      |> validate_inclusion(:age, 18..100)
      |> unique_constraint(:email)
  end
end
