class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  def show
    @user = User.find(params[:id])

    if @user.privacy && !current_user.following?(@user) && @user != current_user
      redirect_to root_path, alert: "このユーザーのプロフィールは非公開です。フォローすると閲覧できます。"
      return
    end

  @posts = @user.posts.order(created_at: :desc)
  end

  def show_mypage
    @user = current_user
    render :show
  end

  def edit
    @user = current_user
  end

  def update_privacy
    current_user.toggle!(:privacy)
    redirect_to mypage_path, notice: "公開設定を変更しました"
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "アカウント情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "退会が完了しました", status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :privacy)
  end

end
