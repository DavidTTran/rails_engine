Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index]
      resources :merchants, except: [:edit, :new]
    end
  end
end
