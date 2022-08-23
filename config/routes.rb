Rails.application.routes.draw do
  namespace :api do
    get '/auth/shake', to: 'authentication#shake'
    post '/auth/login', to: 'authentication#login'
    post '/auth/refresh', to: 'authentication#refresh'
  end
end
