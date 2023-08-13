Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, except: [:show] do
        member do
          get 'exist', to: 'users#exist'
        end
        resources :commits do
          resources :blocks
          resources :sticky_notes, only: [:create, :destroy]
        end
        get 'users/:id', to: 'users#show'
      end
    end
  end
  post 'auth/:provider/callback', to: 'api/v1/users#create'
end
