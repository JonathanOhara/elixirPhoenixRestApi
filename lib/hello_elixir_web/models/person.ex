defmodule HelloElixirWeb.Person do
  use HelloElixirWeb, :model

    schema "persons" do
      field :name, :string
      field :age, :integer
      field :email, :string

      timestamps
  end
end

defimpl Poison.Encoder, for: Person do
  def encode(%{__struct__: _} = struct, options) do
    map = struct
          |> Map.from_struct

    map = Map.drop(map, [:__meta__, :inserted_at, :updated_at])
    Poison.Encoder.Map.encode(map, options)
  end
end
