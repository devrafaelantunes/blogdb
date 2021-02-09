defmodule BlogDB.Model.Comment do
  use Ecto.Schema
  alias BlogDB.Model.{Author, Post, Comment}
  import Ecto.{Changeset, Query}

  @primary_key {:comment_id, :id, autogenerate: true}
  schema "comments" do
    field(:content, :string)

    timestamps()

    belongs_to(:author, Author, foreign_key: :author_id, references: :author_id, on_replace: :delete)
    belongs_to(:post, Post, foreign_key: :post_id, references: :post_id, on_replace: :delete)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:author_id, :post_id, :content])
    |> validate_required([:author_id, :post_id, :content])
    |> foreign_key_constraint(:author_id)
    |> foreign_key_constraint(:post_id)
  end

  def query_by_id(query \\ Comment, id) do
    where(query, [c], c.comment_id == ^id)
  end

  def query_by_author_id(query \\ Comment, author_id) do
    where(query, [c], c.author_id == ^author_id)
  end

  def query_by_post_id(query \\ Comment, post_id) do
    where(query, [c], c.post_id == ^post_id)
  end

  def update_content(comment, new_content) do
    change(comment, content: new_content)
  end
end
