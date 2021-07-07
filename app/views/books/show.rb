require_relative 'book_view'

class Show < BaseView
  include BookView

  def render
    respond(200, html)
  end

  private

  def html
    <<~BODY
      <h1>Book</h1>
      #{render_book(@book)}
    BODY
  end
end