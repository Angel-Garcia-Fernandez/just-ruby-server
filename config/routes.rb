class Routes < BaseRoutes
  def define_routes
    get '/', to: 'books#index'
    get '/books', to: 'books#index'
    get '/books/:id', to: 'books#show'
    get '/writings', redirect_to: '/books'

    get '*', to: 'errors#not_found'
  end
end