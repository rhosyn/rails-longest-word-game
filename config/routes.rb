Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'score', to: 'games#score', as: :score
  get 'reset_game', to: 'games#reset_game', as: :reset_game
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
