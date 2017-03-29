Rails.application.routes.draw do
  devise_for :users, controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'

  resources :cart_items

  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  namespace :account do
    resources :orders
  end

  namespace :admin do
    resources :products do
      member do
        post :move_up
        post :move_down
      end
    end
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  resources :products do
    member do
      post :add_to_cart
      post :favourite
      post :unfavourite
    end
  end

  #  mount RuCaptcha::Engine => "/rucaptcha"
  #mount RuCaptcha::Engine => "/rucaptcha"

end
