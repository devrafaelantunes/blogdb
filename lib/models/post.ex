defmodule BlogDB.Model.Post do
  use Ecto.Schema
  alias BlogDB.Model.{Author, Comment, Post}
  import Ecto.{Changeset, Query}

  @primary_key {:post_id, :id, autogenerate: true}
  schema "posts" do
    field(:title, :string)
    field(:content, :string)

    timestamps()

    has_many(:comments, Comment, foreign_key: :post_id, references: :post_id, on_delete: :delete_all)
    belongs_to(:author, Author, foreign_key: :author_id, references: :author_id, on_replace: :delete)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:author_id, :title, :content])
    |> validate_required([:author_id, :title, :content])
    |> validate_length(:title, max: 150)
    |> foreign_key_constraint(:author_id)
  end

  def query_by_id(query \\ Post, id) do
    where(query, [p], p.post_id == ^id)
  end

  def query_by_title(query \\ Post, title) do
    where(query, [p], p.title == ^title)
  end

  def update_post_content(post, new_content) do
    change(post, content: new_content)
  end
end
