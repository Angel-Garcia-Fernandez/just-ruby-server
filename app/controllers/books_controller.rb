require_relative '../../resources/base_controller.rb'

class BooksController < BaseController
  def index
    render(:index)
  end
end