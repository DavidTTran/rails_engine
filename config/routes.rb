Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, except: [:edit, :new] do
        get "/merchant", to: "merchant_items#merchant"
      end
      resources :merchants, except: [:edit, :new] do
        get "/items", to: "merchant_items#index"
      end
    end
  end
end
