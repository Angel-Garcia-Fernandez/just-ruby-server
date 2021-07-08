module BookView
  def render_book(book)
    <<~BODY
      <p><strong>Name:</strong>#{book.name}</p>
      <p><strong>Date bought:</strong#{book.bought_at}></p>
      <p><strong>ISBN:</strong>#{book.isbn}</p>
    BODY
  end
end