require_relative 'book_view'

class Show < BaseView
  include BookView

  def render
    respond(200, html)
  end

  private

  def html
    <<~BODY
      <h1>Book with ISBN #{@book.isbn} </h1>
      #{render_book(@book)}
      #{button("/books/#{@book.isbn}/update", 'Update')}
      #{button('/books', 'Back to list')}
    BODY
  end
end
