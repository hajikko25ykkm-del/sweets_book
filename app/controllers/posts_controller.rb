class PostsController < ApplicationController
  
  def index
    if user_signed_in? # ログインしている人には、公開ユーザーと自分がフォローしているユーザーの投稿を表示 
      @posts = Post.joins(:user).where(
        "users.privacy = ? OR users.id IN (?) OR users.id = ?", 
        false, 
        current_user.following_ids, 
        current_user.id
      ).order(created_at: :desc)
    else # ログインしていない人には、公開ユーザーの投稿だけ表示
      @posts = Post.joins(:user).where(users: { privacy: false }).order(created_at: :desc)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
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

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

end
