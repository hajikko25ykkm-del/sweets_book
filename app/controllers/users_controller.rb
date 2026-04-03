class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])

    if @user == current_user
      @posts = @user.posts.order(created_at: :desc)
    elsif @user.privacy
      @posts = []
    else
      @posts = @user.posts.where(is_public: true).order(created_at: :desc)
    end
  end

  def show_mypage
    @user = current_user
    render :show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "アカウント情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def following  # 「フォローしている人」のリスト
    @user  = User.find(params[:id])
    @users = @user.followings
  end

  def follows    # 「フォローされている人」のリスト
    @user  = User.find(params[:id])
    @users = @user.followers
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :privacy)
  end
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user), alert: "他人のプロフィールを編集することはできません"
    end
  end
end
