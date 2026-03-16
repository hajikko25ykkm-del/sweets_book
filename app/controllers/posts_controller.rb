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
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    if user_signed_in?
      # 1. 基本条件：投稿自体が「公開(true)」であること
      # 2. ただし「自分の投稿」であれば、非公開でも表示する
      # 3. かつ、投稿主の「ユーザー設定」が公開、または自分がフォローしている人であること
      @posts = Post.joins(:user).where(
        "(posts.is_public = ? OR posts.user_id = ?) AND (users.privacy = ? OR users.id IN (?) OR users.id = ?)",
        true,                      # 投稿が公開
        current_user.id,           # または自分の投稿
        false,                     # ユーザーが公開設定
        current_user.following_ids, # またはフォロー中
        current_user.id            # または自分自身
      ).order(created_at: :desc)
    else
      # ログインしていない人：投稿が公開 かつ ユーザーも公開設定 のものだけ
      @posts = Post.joins(:user).where(posts: { is_public: true }, users: { privacy: false }).order(created_at: :desc)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  def favorites
    @favorite_posts = current_user.favorite_posts
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
