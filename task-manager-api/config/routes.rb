Rails.application.routes.draw do

  post "auth/register"
  post "auth/login"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :tasks

  # get '/tasks', to 'tasks#index'
  # post '/tasks/', to 'tasks#create'
  # get '/tasks/:id', to 'tasks#show'
  # path '/tasks/:id', to 'tasks#update'
  # delete 'tasks/:id', to 'tasks#destroy'
end
