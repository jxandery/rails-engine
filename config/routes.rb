Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/customers/find',      to: 'customers#find'
      get '/customers/find_all',  to: 'customers#find_all'
      get '/customers/random',    to: 'customers#random'
      resources :customers,             except: [:new, :edit] do
        resources :invoices,            only:   [:index], module: :customers
        resources :transactions,        only:   [:index], module: :customers
        resource  :favorite_merchant,   only:    :show,   module: :customers
      end

      get '/invoice_items/find',      to: 'invoice_items#find'
      get '/invoice_items/find_all',  to: 'invoice_items#find_all'
      get '/invoice_items/random',    to: 'invoice_items#random'
      resources   :invoice_items,   except: [:new, :edit] do
        resource  :invoice,         only:    :show, module: :invoice_items
        resource  :item,            only:    :show, module: :invoice_items
      end

      get '/invoices/find',     to: 'invoices#find'
      get '/invoices/find_all', to: 'invoices#find_all'
      get '/invoices/random',   to: 'invoices#random'
      resources   :invoices,      except: [:new, :edit] do
        resources :transactions,  only:   [:index], module: :invoices
        resources :invoice_items, only:   [:index], module: :invoices
        resources :items,         only:   [:index], module: :invoices
        resource  :merchant,      only:    :show,   module: :invoices
        resource  :customer,      only:    :show,   module: :invoices
      end

      get '/items/find',      to: 'items#find'
      get '/items/find_all',  to: 'items#find_all'
      get '/items/random',    to: 'items#random'
      resources   :items,         except: [:new, :edit] do
        resources :invoice_items, only:   [:index], module: :items
        resource  :merchant,      only:    :show,   module: :items
      end

      get '/merchants/find',          to: 'merchants#find'
      get '/merchants/find_all',      to: 'merchants#find_all'
      get '/merchants/random',        to: 'merchants#random'
      get '/merchants/most_items',    to: 'merchants/most_items#index'
      resources   :merchants,                       except: [:new, :edit] do
        resources :items,                           only:   [:index], module: :merchants
        resources :invoices,                        only:   [:index], module: :merchants
        resources :customers_with_pending_invoices, only:   [:index], module: :merchants
        resource  :revenue,                         only:    :show,   module: :merchants
        resource  :favorite_customer,               only:    :show,   module: :merchants
      end

      get '/transactions/find',     to: 'transactions#find'
      get '/transactions/find_all', to: 'transactions#find_all'
      get '/transactions/random',   to: 'transactions#random'
      resources     :transactions,  except: [:new, :edit] do
        resource    :invoice,       only: :show, module: :transactions
      end
    end
  end
end
