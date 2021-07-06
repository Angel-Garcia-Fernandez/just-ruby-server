class Index < BaseView
  def render
    respond(200, 'books')
  end
end