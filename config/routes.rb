Jimvoice::Application.routes.draw do
  root to: 'home#index'
  
  resources :clients, only: :index do
    # resources :invoices
  end
end
