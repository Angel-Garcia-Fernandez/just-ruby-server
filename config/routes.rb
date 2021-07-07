class Routes < BaseRoutes
  def define_routes
    get '/', to: 'books#index'
    get '/books', to: 'books#index'
    get '/books/:id', to: 'books#show'
  end
end