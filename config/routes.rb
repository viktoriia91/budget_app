Rails.application.routes.draw do
  root "expenses#index"
  resources :categories
  resources :expenses
end
