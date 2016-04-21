class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @comments = Comment.where(post_id: @post)
    @comments.inspect
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post)
    else
      render 'new', alert: 'Cannot create posts'
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), alert: 'Updated!'
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, alert: 'Deleted!'
  end


  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :link, :description, :image)
  end

end