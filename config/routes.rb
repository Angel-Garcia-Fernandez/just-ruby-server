class Routes < BaseRoutes
  def define_routes
    get '/', to: 'books#index'

    get '/books', to: 'books#index'
    get '/books/new', to: 'books#new'
    post '/books', to: 'books#create'
    get '/books/:id', to: 'books#show'
    get '/books/:id/edit', to: 'books#edit'
    put '/books/:id', to: 'books#update'
    delete '/books/:id', to: 'books#destroy'

    get '/writings', redirect_to: '/books'

    get '*', to: 'errors#not_found'
  end
end