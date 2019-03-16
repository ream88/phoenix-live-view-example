defmodule App.Country do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias App.Repo

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "countries" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def suggest(query) when query == "", do: __MODULE__ |> limit(0) |> Repo.all()

  def suggest(query) do
    from(c in __MODULE__, where: ilike(c.name, ^"%#{query}%"))
    |> Repo.all()
  end
end
