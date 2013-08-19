SCPX::Application.routes.draw do

  resources :rooms do
    resources :messages
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

  get "main/index"
  root 'main#index'
end
