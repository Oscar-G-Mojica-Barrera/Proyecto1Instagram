class PostsController < ApplicationController
  before_action :authenticate_user! #, except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #autenticar usuario antes de editar o destruir
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
      flash[:notice] = 'Post creado'
      redirect_to posts_path
      #redirect_to_root_path, notice= 'Post creado exitosamente'
    else 
      flash[:alert] = @post.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = 'Post actualizado con exito'
      redirect_to @post
      #redirect_to_root_path, notice= 'Post actualizado exitosamente.'
    else 
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Post eliminado con exito'
    redirect_to posts_path
    #redirect_to_root_path, notice= 'Post eliminado exitosamente.'
  end

  def show
    @post = Post.find(params[:id])
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
