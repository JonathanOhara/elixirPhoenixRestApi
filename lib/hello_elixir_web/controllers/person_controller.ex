defmodule HelloElixirWeb.PersonController do
  use HelloElixirWeb, :controller

  def show(conn, %{"id" => id}) do
    person = Repo.get(HelloElixirWeb.Person, id)
    render(conn, "show.json", person: person)
  end

  def list(conn, _params) do
    persons = Repo.all(HelloElixirWeb.Person)
    json conn, persons
  end

  def findOne(conn, %{"id" => id}) do
    person = Repo.get(HelloElixirWeb.Person, id)
    render(conn, "show.json", person: person)
  end

  def insert(conn, _params) do
    changeset = HelloElixirWeb.Person.changeset(%HelloElixirWeb.Person{}, _params)

    case Repo.insert(changeset) do
      {:ok, newPerson} ->
        conn
        |> put_status(:created)
        |> render("show.json", person: newPerson)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HelloElixirWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id} = person_params) do
    person = Repo.get(HelloElixirWeb.Person, id)

    changeset = HelloElixirWeb.Person.changeset(person, person_params)

    with {:ok, %HelloElixirWeb.Person{} = person} <- Repo.update(changeset) do
      render(conn, "show.json", person: person)
    end
  end

  def delete(conn, %{"id" => id}) do
    person = Repo.get(HelloElixirWeb.Person, id)
    with {:ok, %HelloElixirWeb.Person{}} <- Repo.delete(person) do
      send_resp(conn, :no_content, "")
    end
  end

end
