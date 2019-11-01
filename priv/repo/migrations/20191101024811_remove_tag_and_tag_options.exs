defmodule Camping.Repo.Migrations.RemoveTagAndTagOptions do
  use Ecto.Migration

  def change do
    drop table("trail_tag_options")
    drop table("product_tag_options")
    drop table("tag_options")
    drop table("tags")
  end
end
