Manage::Engine.routes.draw do
  devise_for :users, :controllers => {
    :sessions => "manage/sessions"
  }

  get 'dashboard/index', to: 'dashboard#index'
  root 'dashboard#index'
end
