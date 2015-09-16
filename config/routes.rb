Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/customers/find', to: 'customers#find'
      get '/customers/find_all', to: 'customers#find_all'
      get '/customers/random', to: 'customers#random'
      resources :customers, except: [:new, :edit] do
        resources :invoices, only: [:index], module: :customers
        resources :transactions, only: [:index], module: :customers
        resource :favorite_merchant, only: :show, module: :customers
      end

      get '/invoice_items/find', to: 'invoice_items#find'
      get '/invoice_items/find_all', to: 'invoice_items#find_all'
      get '/invoice_items/random', to: 'invoice_items#random'
      resources :invoice_items, except: [:new, :edit] do
        resource :invoice, only: :show, module: :invoice_items
        resource :item, only: :show, module: :invoice_items
      end

      get '/invoices/find', to: 'invoices#find'
      get '/invoices/find_all', to: 'invoices#find_all'
      get '/invoices/random', to: 'invoices#random'
      resources :invoices, except: [:new, :edit] do
        resource :customer, only: :show, module: :invoices
        get '/merchant', to: 'invoices#merchant'
        get '/transactions', to: 'invoices#transactions'
        get '/invoice_items', to: 'invoices#invoice_items'
        get '/items', to: 'invoices#items'
      end

      get '/items/find', to: 'items#find'
      get '/items/find_all', to: 'items#find_all'
      get '/items/random', to: 'items#random'
      resources :items, except: [:new, :edit] do
        get '/invoice_items', to: 'items#invoice_items'
        get '/merchant', to: 'items#merchant'
      end

      get '/merchants/find', to: 'merchants#find'
      get '/merchants/find_all', to: 'merchants#find_all'
      get '/merchants/random', to: 'merchants#random'
      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'merchants#items'
        get '/invoices', to: 'merchants#invoices'
        get '/revenue', to: 'merchants#revenue'
        get '/favorite_customer', to: 'merchants#favorite_customer'
        get '/customers_with_pending_invoices', to: 'merchants#customers_with_pending_invoices'
      end

      get '/transactions/find', to: 'transactions#find'
      get '/transactions/find_all', to: 'transactions#find_all'
      get '/transactions/random', to: 'transactions#random'
      resources :transactions, except: [:new, :edit] do
        get '/invoice', to: 'transactions#invoice'
      end
    end
  end
end
