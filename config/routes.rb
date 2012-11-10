Petstorish::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root :to => 'products#home'

  resources :options

  devise_for :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  match '/cart' => 'carts#edit', :as => :cart
  match '/cart/checkout' => 'carts#checkout', :as => :cart_checkout
  match '/cart/receipt' => 'carts#receipt', :as => :cart_receipt
  match '/orders' => 'orders#create', :via => 'post'

  resources :line_items

  resources :products

  resources :charges

  match '/s/' => 'products#adv_search', :via => :get
  match '/s/:query' => 'products#search', :via => :get
  match '/:category' => 'products#list'
  match '/:category/s/:query' => 'product#search'

  resources :users
end
