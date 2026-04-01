class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @post.post_ingredients.build
    @post.steps.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post)
    else
      @post.post_ingredients.build if @post.post_ingredients.empty?
      @post.steps.build if @post.steps.empty?
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.viewable_by(current_user).find(params[:id])
  end

  def index
    @posts = Post.viewable_by(current_user).order(created_at: :desc)
    
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @posts = @posts.where(genre_id: params[:genre_id])
    end

    @posts = @posts.page(params[:page]).per(20)
    @genres = Genre.all 
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :body, :image, :genre_id, :is_public,
      post_ingredients_attributes: [:id, :ingredient_name, :quantity, :is_shopping_list, :_destroy],
      steps_attributes: [:id, :content, :position, :image, :_destroy])
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to posts_path, alert: "他人の投稿を編集・削除することはできません"
    end
  end
end
