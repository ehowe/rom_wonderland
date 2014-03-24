RomWonderland::Application.routes.draw do
  devise_for :users

  resources :systems, :games

  get  "/systems/:id/games"        => "systems_games#index", as: :systems_games
  post "/systems/:id/games"        => "systems_games#create"
  get  "/systems/:id/games/new"    => "systems_games#new",   as: :new_systems_game

  # javascript autocomplete
  get  "/systems/:id/games/search" => "systems#search",      as: :search_games


  root to: "home#welcome"
end
