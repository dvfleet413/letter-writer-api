Rails.application.routes.draw do
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
  get '/get_current_user', to: "sessions#get_current_user"
  get '/get_daily_text', to: "text#todays_text"
  resources :contacts, only: [:index, :create]
  resources :congregations do
    resources :external_contacts, only: [:index, :create]
    resources :territories, only: [:index, :show] do 
      resources :dncs
    end
    resources :dncs, only: [:index, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
