module BookView
  def render_book(book)
    <<~BODY
      <p><strong>Title:</strong>#{book.title}</p>
      <p><strong>Date bought:</strong>#{book.bought_at}</p>
      <p><strong>ISBN:</strong>#{book.isbn}</p>
    BODY
  end

  def render_book_row(book)
    <<~BODY
      <tr><td>#{book.bought_at}</td><td><img src='#{book.cover}'alt='#{book.title}'/></td>
      <td>#{book.isbn}</td><td>#{book.title}</td><td>#{book.author}</td><td>#{book.published_at}</td>
      <td>#{book.pages}</td></tr>
    BODY
  end
end
