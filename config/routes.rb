Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
    #don't have to change any views because new and edit both use the same _form partial that already has the author_id
  end
  resources :posts
end
