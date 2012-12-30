Jimvoice::Application.routes.draw do
  root to: 'home#index'
  
  resources :clients, only: :index do
    resources :invoices, except: :destroy do
      resources :invoice_items
    end
  end
end
