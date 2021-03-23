Rails.application.routes.draw do
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
  get '/get_current_user', to: "sessions#get_current_user"
  get '/get_daily_text', to: "text#todays_text"
  resources :congregations do
    resources :contacts, only: [:index]
    resources :territories, only: [:index, :show] do 
      resources :dncs
    end
    resources :dncs, only: [:index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
