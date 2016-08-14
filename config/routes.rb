ShoppingCart::Engine.routes.draw do
  root 'order_items#index'
  resources :order_items
  resources :checkout, only: [:index, :create]
  post 'clear', to: 'order_items#destroy_items', as: 'clear_cart'
  post 'discount', to: 'order_items#discount', as: 'discount'
end
