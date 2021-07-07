require_relative 'book_view'

class Index < BaseView
  include BookView

  def render
    respond(200, html)
  end

  private

  def html
    <<~BODY
      <h1>All books</h1>
      <ol>
        <li>
          #{@books.map { |b| render_book(b) }.join('</li><li>')}
        </li>
      </ol>
    BODY
  end
end