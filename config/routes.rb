RomWonderland::Application.routes.draw do
  devise_for :users

  resources :systems, :games, :emulators

  get  "/systems/:id/games"        => "systems_games#index", as: :systems_games
  post "/systems/:id/games"        => "systems_games#create"
  get  "/systems/:id/games/new"    => "systems_games#new",   as: :new_systems_game

  get  "/systems/:id/emulators"     => "systems_emulators#index", as: :systems_emulators
  post "/systems/:id/emulators"     => "systems_emulators#create"
  get  "/systems/:id/emulators/new" => "systems_emulators#new",   as: :new_systems_emulator

  # javascript autocomplete
  get  "/systems/:id/games/search" => "systems#search",      as: :search_games


  root to: "home#welcome"
end
