Rails.application.routes.draw do
  get 'round/create'
  post 'round/create', to: 'round#create_post'
  get 'round/:id', to: 'round#show'
  get 'round/:id/draft', to: 'round#draft'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
