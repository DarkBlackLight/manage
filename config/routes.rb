Manage::Engine.routes.draw do
  devise_for :users, {
    class_name: 'User',
    module: :devise
  }
  
  get 'dashboard/index', to: 'dashboard#index'
  root 'dashboard#index'
end
