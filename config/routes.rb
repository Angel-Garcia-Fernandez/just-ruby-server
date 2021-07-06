class Routes < BaseRoutes
  def define_routes
    get '/books', to: 'books#index'
  end
end