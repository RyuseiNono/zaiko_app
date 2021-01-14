Rails.application.routes.draw do
  root to: "shops#index"
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  resources :shops do
    resources :items
    resources :favorites , only: [:create, :destroy]
    collection do
      get :my
      post :confirm
    end
  end
  get 'items/search'
  resources :favorites , only: [:index]
end
