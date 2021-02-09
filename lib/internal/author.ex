defmodule BlogDB.Internal.Author do
  alias BlogDB.Model.Author
  alias BlogDB.Repo
  import Ecto.Changeset

  def insert(params) do
    params
    |> Author.changeset()
    |> Repo.insert()
  end

  def fetch(id) do
    id
    |> Author.query_by_id()
    |> Repo.one()
    |> Repo.preload([:posts, :comments]) #[{:posts, :comments}]
  end

  def fetch2(id) do
    import Ecto.Query

    from(a in Author,
      left_join: p in assoc(a, :posts),
      left_join: c in assoc(a, :comments),
      left_join: pc in assoc(p, :comments), #model // assoc
      where: a.author_id == ^id,
      select: %{
        username: a.username,
        post_title: p.title,
        comment_content: c.content,
        post_comments: pc.content
      }
    )
    |> Repo.all()


    # from(a in Author,
    #   left_join: p in Post,
    #   on: p.author_id == a.author_id,
    #   where: a.author_id == ^id
    # )
  end

  def fetch_by_username(username) do
    username
    |> Author.query_by_username()
    |> Repo.one()
  end

  def delete_by_id(id) do
    #where(Post, [p], p.author_id == ^id)
    #|> Repo.delete_all()

    #where(Comment, [c], c.author_id == ^id)
    #|> Repo.delete_all()

    id
    |> Author.query_by_id()
    |> Repo.delete_all()
  end

  def update_username(id, new_username) do
    fetch(id)
    |> Author.update_username(new_username)
    |> Repo.update()
  end
end
