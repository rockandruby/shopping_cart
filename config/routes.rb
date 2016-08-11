ShoppingCart::Engine.routes.draw do
  resources :orders
  resources :order_items
  post 'clear', to: 'order_items#destroy_items'
  patch '/order/update', to: 'orders#update', as: 'update_order'
end
