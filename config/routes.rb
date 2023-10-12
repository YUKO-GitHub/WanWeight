Rails.application.routes.draw do
  root 'static_pages#home'
  get :terms, to: 'static_pages#terms'
  get :privacy_policy, to: 'static_pages#privacy_policy'
  get :mypage, to: 'mypages#show'
  get 'profiles/show'
  get 'profiles/edit'
  patch 'profiles/show', to: 'profiles#update'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }

  resources :users, only: [:show]

end
