class Show < BaseView
  def render
    respond(200, "book with id #{@params['id']}")
  end
end