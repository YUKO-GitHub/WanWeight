Rails.application.routes.draw do
  get 'users/new'
  get 'users/show'
  get 'users/index'
  root 'static_pages#home'
  get :terms, to: 'static_pages#terms'
  get :privacy_policy, to: 'static_pages#privacy_policy'
end
