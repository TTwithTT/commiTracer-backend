Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :commits do
          resources :blocks
        end
      end
      resources :commits, only: [:index]
    end
  end
  post 'auth/callback/:provider', to: 'api/v1/users#create'
  delete 'users/:email', to: 'api/v1/users#destroy', constraints: { email: %r{[^/]+} } 
end
