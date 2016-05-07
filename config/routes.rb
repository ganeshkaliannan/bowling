Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  resources :bowling_games do
    member do
      get "bowling_frame"
      get "calculate_score"
    end
    collection do
      post "score_collecter"
    end
  end
end
