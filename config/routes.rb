SCPX::Application.routes.draw do
  resources :notifications, only: [:index, :show] do
    put 'read', on: :member, as: :read
    put 'read_all', on: :collection, as: :read_all
    put 'destroy_read', on: :collection, as: :delete_read
  end

  resources :rooms do
    resources :messages, only: [:create, :show]
    get 'history', on: :member
  end
  resources :users, only: [:show, :edit, :update]

  devise_for :users, {
    path: '',
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    },
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      sign_up: 'registration',
      password: 'amnesia',
      confirmation: 'verification',
      unlock: 'unblock',
      registration: 'account'
    }
  }


  constraints subdomain: /^[A-Za-z0-9-]+$/ do
    get '/' => 'namespace#show'
    get '/pages' => 'pages#index'
    post '/pages' => 'pages#create'
    resources :pages, path: ''
    resources :pages, path: '' do
      resources :versions, only: [:index, :show] do
        get 'rollback', on: :member
        get 'diff', on: :collection
      end
      resources :comments
      resources :votes, only: [:index, :create, :update, :destroy]
    end
  end

  get '/' => 'namespace#show'
  get '/pages' => 'pages#index'
  match 'api/markdown', to: 'main#markdown_preview', via: [:get, :post], as: :markdown_preview
  resources :messages
  post '/pages' => 'pages#create'
  resources :pages, path: '' do
    resources :versions, only: [:index, :show] do
      get 'rollback', on: :member
      get 'diff', on: :collection
    end
    resources :comments
    resources :votes, only: [:index, :create, :update, :destroy]
  end

  get "main/index"
  root 'main#index'
end
