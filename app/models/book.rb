class Book < BaseModel
  set_fields(:isbn, :title, :cover, :author, :published_at, :pages, :bought_at)
  set_id_field(:isbn)
end