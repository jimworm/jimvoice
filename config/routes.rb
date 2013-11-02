Jimvoice::Application.routes.draw do
  root to: 'home#index'
  
  resources :clients, except: :destroy do
    resources :invoices, except: :destroy do
      resources :invoice_items, except: [:index, :show]
      member { put :issue, :pay }
    end
  end
end
