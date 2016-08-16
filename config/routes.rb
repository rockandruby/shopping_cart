ShoppingCart::Engine.routes.draw do
  root 'order_items#index'
  resources :order_items
  resources :checkout, only: [:index, :create]
  scope :checkout do
    ShoppingCart::order_steps.try(:each) do |step|
      get "/#{step}", to: "checkout##{step}"
      post "/add_#{step}", to: "checkout#add_#{step}"
    end
    get '/complete', to: 'checkout#complete', as: 'complete'
    post '/add_address', to: 'checkout#add_address', as: 'add_address'
  end
  post 'clear', to: 'order_items#destroy_items', as: 'clear_cart'
  post 'discount', to: 'order_items#discount', as: 'discount'
end
