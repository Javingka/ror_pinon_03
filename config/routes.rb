Rails.application.routes.draw do

  root 'static_pages#home'

	get	'home' => 'static_pages#home'
	get	'help' => 'static_pages#help'
	get 'about' => 'static_pages#about'
	get 'customapp' => 'static_pages#customapp'
	post 'fetch_estanque' => 'static_pages#fetch_estanque'
	post 'fetch_aplicacion' => 'static_pages#fetch_aplicacion'
	post 'fetch_asiento' => 'static_pages#fetch_asiento'
	post 'fetch_manilla' => 'static_pages#fetch_manilla'
	post 'save_changes' => 'static_pages#save_changes'
	post 'contact_create' => 'static_pages#contact_create'
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
  
  resources :custom_apps,          only: [:create, :destroy]
end
