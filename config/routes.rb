NwcopyServer::Application.routes.draw do
  match 'oauth/callback' => 'users#callback'
  match 'me'             => 'users#show'

  resources :pastes
  match 'copy'   => 'pastes#create'
  match 'paste'  => 'pastes#show'
end
