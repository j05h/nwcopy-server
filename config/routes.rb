NwcopyServer::Application.routes.draw do
  match 'oauth/callback' => 'users#callback'
  match 'me'             => 'users#show'
end
