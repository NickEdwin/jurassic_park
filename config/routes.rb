Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/cages', to: 'cages#create'
      get '/cages', to: 'cages#index'
      get '/cages/:id', to: 'cages#show'
      patch '/cages/:id', to: 'cages#update'

      post '/dinosaurs', to: 'dinosaurs#create'
    end
  end
end
