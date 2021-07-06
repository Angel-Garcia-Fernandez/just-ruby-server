require_relative '../../../resources/base_view'

class Index < BaseView
  def render
    respond(200, 'books')
  end
end