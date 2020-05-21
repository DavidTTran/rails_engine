Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/revenue", to: "merchants#revenue_by_date"

      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/most_revenue", to: "revenue#index"
        get "/:merchant_id/revenue", to: "revenue#show"
        get "/most_items", to: "items#index"
      end

      resources :merchants, except: [:edit, :new] do
        get "/items", to: "merchant_items#index"
      end

      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end

      resources :items, except: [:edit, :new] do
        get "/merchant", to: "merchant_items#merchant"
      end
    end
  end
end
