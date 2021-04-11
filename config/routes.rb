Rails.application.routes.draw do
  get '/', to: redirect('round/create')

  get 'round/create'
  
  # Runs the 'create_post' method in app/controllers/round_controller.rb
  # And displays app/views/round/create.html.erb
  post 'round/create', to: 'round#create_post'
  
  # Runs the 'show' method in app/controllers/round_controller.rb
  # And displays app/views/round/show.html.erb
  get 'round/:id', to: 'round#show'

  # Runs the 'draft' method in app/controllers/round_controller.rb
  # And displays app/views/round/draft.html.erb
  get 'round/:id/draft', to: 'round#draft'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
