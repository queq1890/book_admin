Rails.application.routes.draw do
  resources :publishers do
    resources :books

    member do
      get 'detail'
    end

    collections do
      get 'search'
    end
  end
end
