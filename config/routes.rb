Rails.application.routes.draw do
  #namespace :api do
  #  resources :books
  #end

  resources :books do
    member do
      post :reserve
    end
  end
end
