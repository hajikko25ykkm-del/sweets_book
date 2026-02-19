class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    if @user.privacy && !current_user.following?(@user) && @user != current_user
      redirect_to posts_path, alert: "このユーザーのプロフィールは非公開です。フォローすると閲覧できます。"
      return
    end
    @posts = @user.posts.order(created_at: :desc)
  end

  def show_mypage
    @user = current_user
    render :show
  end

  def edit
  end

  def update_privacy
    current_user.toggle!(:privacy)
    redirect_to mypage_path, notice: "公開設定を変更しました"
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, notice: "アカウント情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "退会が完了しました", status: :see_other
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings # 「フォローしている人」のリストを @users に入れる
  end

  def follows
    @user  = User.find(params[:id])
    @users = @user.followers  # 「フォローされている人」のリストを @users に入れる
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
