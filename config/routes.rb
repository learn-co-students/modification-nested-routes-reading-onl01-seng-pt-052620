Rails.application.routes.draw do
  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end 
  resources :posts 
end

# This Gives Us Access To: 
# /authors/:author_id/posts/new  
# new_author_post_path HELPER 