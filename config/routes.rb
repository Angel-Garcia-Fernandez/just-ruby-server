class Routes < BaseRoutes
  def define_routes
    get '/books', to: 'books#index'
    get '/books/:id', to: 'books#show'
  end
end