class PostsController < ApplicationController
  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
  end

  def new
    if params[:author_id] && !Author.exists?(params[:author_id]) 
      redirect_to authors_path, alert: "Author not found"
    else 
      @post = Post.new(author_id: params[:author_id])
    # Making sure that if we capture an author_id through a nested route, 
    # we keep track of it and assign the post to that author. 
    end
  end 

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit   #CONFUSED ?? 
    if params[:author_id]  #Checking if it exists, comes from nested route.  
      author = Author.find_by(id: params[:author_id]) 
      if author.nil? 
        redirect_to authors_path, alert: "Author not found."  #If an author isn't found 
      else 
        @post = author.posts.find_by(id: params[:id])
        redirect_to author_posts_path(author), alert: "Post not found." if @post.nil? 
      end 
    else 
      @post = Post.find(params[:id])
  end
end 

  private

  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
