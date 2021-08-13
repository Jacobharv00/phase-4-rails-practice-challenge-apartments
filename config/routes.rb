Rails.application.routes.draw do
  # added :index to leases just to see data
  resources :leases, only: [:index, :create, :destroy]
  resources :tenants, only: [:index, :create, :update, :destroy]
  resources :apartments, only: [:index, :create, :update, :destroy]
end
