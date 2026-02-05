class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer # request.refererで直前のページにリダイレクト
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def followings # 自分がフォローしている人一覧
  user = User.find(params[:user_id])
  @users = user.followings
  end

  def followers # 自分をフォローしている人一覧
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
