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
  devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admins/sessions#new_guest'
  end

  resources :shops do
    resources :items
    post 'items/:id', to:'items#update'
    # 何故かAJAXで作成した更新ボタンがPATCHではなくPOSTするので、その対策
    resources :favorites , only: [:create, :destroy]
    collection do
      get :my
      post :confirm
    end
  end

  resources :favorites , only: [:index]
  get 'items/search'
  get 'entrances/registrations'
  get 'entrances/sessions'
  get 'entrances/user_chanege_desroy'
end
