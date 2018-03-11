Rails.application.routes.draw do
  resource :profile

  resources :publishers do
    resources :books

    member do
      get 'detail'
    end

    collection do
      get 'search'
    end
  end
end
