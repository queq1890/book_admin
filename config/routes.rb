Rails.application.routes.draw do
  resource :profile, only: %i{show edit update}
  resources :books

  resources :publishers do


    member do
      get 'detail'
    end

    collection do
      get 'search'
    end
  end
end
