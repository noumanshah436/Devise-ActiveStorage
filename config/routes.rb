Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'

  root to: "home#index"

  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end
end
