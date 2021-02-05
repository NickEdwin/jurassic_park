Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/cages', to: 'cages#create'
      post '/dinosaurs', to: 'dinosaurs#create'
    end
  end
end
