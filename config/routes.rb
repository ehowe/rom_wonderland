RomWonderland::Application.routes.draw do
  devise_for :users

  resources :systems, :games

  get  "/systems/:id/games" => "systems_games#index", as: :systems_games
  post "/systems/:id/games" => "systems_games#create"


  root to: "home#welcome"
end
