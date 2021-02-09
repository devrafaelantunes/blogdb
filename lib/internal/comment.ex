defmodule BlogDB.Internal.Comment do
  alias BlogDB.Model.Comment
  alias BlogDB.Repo

  def insert(params) do
    params
    |> Comment.changeset()
    |> Repo.insert()
  end

  def fetch(id) do
    id
    |> Comment.query_by_id()
    |> Repo.one()
  end

  def fetch_by_author_id(author_id) do
    author_id
    |> Comment.query_by_author_id()
    |> Repo.all()
  end

  def fetch_by_post_id(post_id) do
    post_id
    |> Comment.query_by_post_id()
    |> Repo.all()
  end

  def delete_by_id(id) do
    id
    |> Comment.query_by_id()
    |> Repo.delete_all()
  end

  def update_content(comment_id, new_content) do
    fetch(comment_id)
    |> Comment.update_content(new_content)
    |> Repo.update()
  end
end
