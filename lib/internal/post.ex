defmodule BlogDB.Internal.Post do
  alias BlogDB.Model.Post
  alias BlogDB.Repo

  def insert(params) do
    params
    |> Post.changeset()
    |> Repo.insert()
  end

  def fetch(id) do
    id
    |> Post.query_by_id()
    |> Repo.one()
  end

  def fetch_by_title(title) do
    title
    |> Post.query_by_title()
    |> Repo.all()
  end

  def delete_by_id(id) do
    id
    |> Post.query_by_id()
    |> Repo.delete_all()
  end

  def update_post_content(post_id, new_content) do
    fetch(post_id)
    |> Post.update_post_content(new_content)
    |> Repo.update()
  end
end
