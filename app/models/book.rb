class Book < BaseModel
  set_fields(:isbn, :name, :bought_at)
  set_id_field(:isbn)
end