Rails.application.routes.draw do
  root to: 'users#index'
  get 'users/verify_email', to: 'users#verify_email'
end
