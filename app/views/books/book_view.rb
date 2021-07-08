module BookView
  def render_book(book)
    <<~BODY
      <p><strong>Title:</strong>#{book.title}</p>
      <p><strong>Date bought:</strong>#{book.bought_at}</p>
      <p><strong>ISBN:</strong>#{book.isbn}</p>
      <p><strong>Cover:</strong><img src='#{book.cover}'alt='#{book.title}'/></p>
      <p><strong>Author:</strong>#{book.author}</p>
      <p><strong>Number of pages:</strong>#{book.pages}</p>
      <p><strong>Published on:</strong>#{book.published_at}</p>
    BODY
  end

  def render_book_row(book)
    <<~BODY
      <tr><td>#{book.bought_at}</td><td><img src='#{book.cover}'alt='#{book.title}'/></td>
        <td>#{book.isbn}</td><td>#{book.title}</td><td>#{book.author}</td><td>#{book.published_at}</td>
        <td>#{book.pages}</td><td>#{button("/books/#{book.isbn}/edit", 'Edit')} #{button("/books/#{book.isbn}/update", 'Update')}</td></tr>
    BODY
  end

  def button(path, text)
    dest = "window.location.href='#{path}'"
    "<button onclick=#{dest}>#{text}</button>"
  end
end
