Rails.application.routes.draw do

  root 'static_pages#home'
  #root :to => redirect("https://www.facebook.com/tallerpinon?fref=ts")

	get	'home' => 'static_pages#home'
	get	'help' => 'static_pages#help'
	get 'about' => 'static_pages#about'
	get 'customapp' => 'static_pages#customapp'
	post 'fetch_pieza' => 'static_pages#fetch_pieza'
	post 'save_changes' => 'static_pages#save_changes'
	post 'contact_create' => 'static_pages#contact_create'
	get 'tu_pinon' => 'static_pages#tu_pinon'
	get 'contact' => 'static_pages#contact'
	get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
	resources :users do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :motos,               only: [:index, :new, :create, :destroy, :edit, :update, :show]
  get 'index_pinon' => 'motos#indexPinon'
  
  resources :custom_apps,          only: [:create, :destroy, :update, :index, :show, :index]
  post 'recarga' => 'custom_apps#recarga'

  get 'auth/:provider/callback', to: 'users#omniauth_listener'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

end
