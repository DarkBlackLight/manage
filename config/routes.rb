Manage::Engine.routes.draw do
  get 'dashboard/index', to: 'dashboard#index'
  root 'dashboard#index'
end
