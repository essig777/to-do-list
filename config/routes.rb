Rails.application.routes.draw do
  resources :tasks
  resources :users do
    collection do
      post :register
    end
  end
  resources :comments

  #User
  #Task
  
  get '/tasks/:id/comment', to: 'tasks#list_comment'
  post '/tasks/:id/create_comment', to: 'tasks#create_comment'
  patch '/tasks/:id/remove_image', to: 'tasks#remove_image'
  get '/tasks/:id/situations', to: 'tasks#show_enum'
  patch '/tasks/:id/add_user', to: 'tasks#add_user_to_task'

  #Comment
  
  get '/comments/:id/comment', to: 'comments#show_comment'

  mount_devise_token_auth_for 'User', at: 'auth'

  #Enum
  
  get '/tasks_enum', to: 'situations#index'
end
