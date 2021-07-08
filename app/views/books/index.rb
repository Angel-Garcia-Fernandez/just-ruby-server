require_relative 'book_view'

class Index < BaseView
  include BookView

  def render
    respond(200, html)
  end

  private

  def html
    <<~BODY
      <head>
        <style>
          #{css}
        </style>
      </head>
      <h1>All books</h1>
      <table><thead><tr><th colspan='7'>Books</th></tr></thead>
      <tr><td>Date bought</td><td>Cover</td><td>ISBN</td><td>Title</td><td>Author</td>
      <td>Date published</td><td>Pages</td></tr>
      #{@books.each { |book| render_book_row(book)}}
      </table><p></p><button onclick="window.location.href='/books/new'">Click to add a new book</button>
    BODY
  end

  def css
    <<~BODY
      table,
      td {
        border: 1px solid #333;
      }

      thead,
      tfoot {
        background-color: #333;
          color: #fff;
      }
    BODY
  end
end
