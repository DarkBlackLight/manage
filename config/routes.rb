Manage::Engine.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }
  get 'dashboard/index', to: 'dashboard#index'
  root 'dashboard#index'
end
