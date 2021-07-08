class ErrorsController < BaseController
  def not_found
    render(:not_found)
  end

  def error
    render(:error)
  end
end
