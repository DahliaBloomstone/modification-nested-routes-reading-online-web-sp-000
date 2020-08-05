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

#We have the route, now update new action to handle the :author_id param
#if we capture author_id through a nested route, we keep track of it
# and assign the post to that author
  def new
    @post = Post.new(author_id: params[:author_id])
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

  def edit
    @post = Post.find(params[:id])
  end

  private

#strong params
#post controller must accept :author_id as a param for a post
#strong params = security practice to help prevent allowing users to update sensitive model attributes
# author_id allowed for mass assignment in the create action  
  def post_params
    params.require(:post).permit(:title, :description, :author_id)
  end
end
