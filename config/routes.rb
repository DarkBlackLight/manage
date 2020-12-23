Manage::Engine.routes.draw do
  devise_for :users
  get 'dashboard/index', to: 'dashboard#index'
end
