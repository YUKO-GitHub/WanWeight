Rails.application.routes.draw do
  root 'static_pages#home'
  get :mypage, to: 'mypages#show'
  get 'account', to: 'users#show', as: 'user'
  get 'profiles', to: 'profiles#show'
  get 'profiles/edit'
  patch 'profiles', to: 'profiles#update'

  devise_for :users, skip: [:registrations, :sessions] 

  devise_scope :user do
    get 'sign_up', to: 'users/registrations#new', as: 'new_user_registration'
    post 'sign_up', to: 'users/registrations#create', as: 'user_registration'
    get 'edit_account', to: 'users/registrations#edit', as: 'edit_user_registration'
    patch 'edit_account', to: 'users/registrations#update', as: 'update_user_registration'
    delete 'delete_account', to: 'users/registrations#destroy', as: 'delete_user_registration'
    get 'sign_in', to: 'users/sessions#new', as: 'new_user_session'
    post 'sign_in', to: 'users/sessions#create', as: 'user_session'
    delete 'sign_out', to: 'users/sessions#destroy', as: 'destroy_user_session'
    get 'guest_sign_in', to: 'users/sessions#guest_sign_in', as: 'guest_sign_in'
  end

  resources :user_weights
  resources :dogs do
    resources :dog_weights
  end
  resources :diaries
end
