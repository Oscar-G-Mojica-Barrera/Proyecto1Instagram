class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save 
      redirect_to_root_path, notice= 'Post creado exitosamente'
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to_root_path, notice= 'Post actualizado exitosamente.'
    else 
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to_root_path, notice= 'Post eliminado exitosamente.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    redirect_to_root_path, alert= 'No autorizado' unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:description, :image)
  end
end
