Rails.application.routes.draw do
  root 'static_pages#home'
  get :terms, to: 'static_pages#terms'
  get :privacy_policy, to: 'static_pages#privacy_policy'
end
