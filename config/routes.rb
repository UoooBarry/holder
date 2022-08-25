Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    get '/auth/shake', to: 'authentication#shake'
    post '/auth/login', to: 'authentication#login'
    post '/auth/refresh', to: 'authentication#refresh'
    post '/auth/logout', to: 'authentication#logout'

    resources :users, only: [:create]

    resources :communities do
      member do
        post :subscribe
        post :unsubscribe
      end
    end

    resources :posts
  end
end
