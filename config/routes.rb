require_relative '../resources/base_routes'

class Routes < BaseRoutes
  def define_routes
    get '/books', to: 'books#index'
  end
end