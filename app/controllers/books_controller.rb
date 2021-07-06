class BooksController < BaseController
  def index
    render(:index)
  end

  def show
    render(:show)
  end
end