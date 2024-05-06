Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'home#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
end
