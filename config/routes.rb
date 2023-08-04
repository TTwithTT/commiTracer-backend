Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        member do
          get 'exist', to: 'users#exist'
        end
        resources :commits do
          resources :blocks
        end
      end
    end
  end
  post 'auth/:provider/callback', to: 'api/v1/users#create'
end
