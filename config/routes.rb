Rails.application.routes.draw do
  root 'pages#home'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :categories

  get 'plans', to: 'pages#plans'
  post 'checkout/create', to: 'checkout#create', as: 'checkout_create'
  post 'billing_portal/create', to: 'billing_portal#create', as: 'billing_portal_create'
  post 'webhooks', to: 'webhooks#create'

  get 'search/index'
end
