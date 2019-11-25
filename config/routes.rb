Rails.application.routes.draw do
  get 'orderitems/index'

  get 'orderitems/show'

  get 'orderitems/new'

  get 'orderitems/edit'

  resources :orders do
    resources:orderitems
  end
  
  resources :categories
  
  devise_for :users do
      resources :orders
  end
  
  get '/checkout' => 'cart#createOrder'
  
  get 'cart/index'

 resources :items
 root 'static_pages#home'
 
 get '/about' =>'static_pages#about'
 get '/donuts' => 'static_pages#donuts'
 get '/order' => 'static_pages#order'
 get '/contact' => 'static_pages#contact'
 
 get '/login' => 'user#login'
 get '/logout' => 'user#logout'
 
 get '/cart/:id', to: 'cart#add'
 get '/cart', to: 'cart#index'
 get '/clearcart', to: 'cart#clearCart'
 get '/cart/remove/:id' => 'cart#remove'
 get '/cart/decrease/:id' => 'cart#decrease'
 
 root :to => 'site#home'
  
  #get 'static_pages/home'
  #get 'static_pages/about'
  #get 'static_pages/donuts'
  #get 'static_pages/register'
  #get 'static_pages/order'
  #get 'static_pages/login'
  #get 'static_pages/contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
