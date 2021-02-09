defmodule BlogDB.Model.Author do
  import Ecto.{Changeset, Query}
  use Ecto.Schema
  alias BlogDB.Model.{Post, Comment, Author}

  @primary_key {:author_id, :id, autogenerate: true}
  schema "authors" do
    field(:username, :string)
    field(:password, :string)
    field(:email, :string)

    timestamps()

    has_many(:posts, Post, foreign_key: :author_id, on_delete: :delete_all)
    has_many(:comments, Comment, foreign_key: :author_id, on_delete: :delete_all)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:username, :password, :email])
    |> validate_required([:username, :password, :email])
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
  end

  def query_by_id(query \\ Author, id) do
    where(query, [a], a.author_id == ^id)
  end

  def query_by_username(query \\ Author, username) do
    where(query, [a], a.username == ^username)
  end

  def update_username(author, new_username) do
    change(author, username: new_username)
  end
end
