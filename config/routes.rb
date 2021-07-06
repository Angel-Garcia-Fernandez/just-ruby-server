require_relative '../resources/base_routes'

class Routes < BaseRoutes
  def self.routes
    get '/books', to: 'books#index'
  end
end