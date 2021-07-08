class Routes < BaseRoutes
  def define_routes
    get '/', to: 'books#index'

    get '/books', to: 'books#index'
    get '/books/new', to: 'books#new'
    post '/books', to: 'books#create'
    get '/books/:isbn', to: 'books#show'
    get '/books/:isbn/edit', to: 'books#edit'
    put '/books/:isbn', to: 'books#update'
    delete '/books/:isbn', to: 'books#destroy'

    get '/writings', redirect_to: '/books'

    get '*', to: 'errors#not_found'
  end
end