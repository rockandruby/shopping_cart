ShoppingCart::Engine.routes.draw do
  root 'order_items#index'
  resources :order_items
  resources :checkout, only: [:index, :create]
  scope :checkout do
    get '/shipping', to: 'checkout#shipping'
    get '/payment', to: 'checkout#payment'
  end
  post 'clear', to: 'order_items#destroy_items', as: 'clear_cart'
  post 'discount', to: 'order_items#discount', as: 'discount'
end
