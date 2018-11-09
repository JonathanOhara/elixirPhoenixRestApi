defmodule HelloElixirWeb.PersonController do
  use HelloElixirWeb, :controller

  def list(conn, _params) do
    persons = Repo.all(HelloElixirWeb.Person)
    json conn, persons
  end

  def insert(conn, _params) do
    IO.inspect(_params, label: "p: ")
    newPerson = HelloElixirWeb.Person.changeset(%HelloElixirWeb.Person{}, _params)

    {:error, newPerson} = Repo.insert(newPerson)

    IO.puts "AEW"

    IO.inspect(newPerson.errors, label: "error: ")

    errors = []

    errors = Enum.reduce(newPerson.errors, [], fn (field_error, errors) ->
      {field, {error_message, _}} = field_error
      errors = ["#{field} #{error_message}" | errors]
    end)

    conn
      |> send_resp(500, errors)
      |> halt()
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &HelloElixirWeb.ErrorHelpers.translate_error/1)
  end

end
