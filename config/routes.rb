Rails.application.routes.draw do
  resources :users, except: [:index] do
    resources :circles, only: [:index]
  end

  resources :circles, only: [:new, :show, :edit, :create, :update]

  resources :posts, only: [:new, :create, :show, :edit]

  resource :session, only: [:new, :create, :destroy]

  get 'feed', to: 'posts#feed'
end
