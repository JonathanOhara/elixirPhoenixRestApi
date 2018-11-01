defmodule HelloElixirWeb.PersonController do
  use HelloElixirWeb, :controller

  def index(conn, _params) do
    persons = Repo.all(HelloElixirWeb.Person)
    IO.inspect(persons, label: "x: ")
    json conn, persons
  end
end
