class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:top, :about] # ログインの確認追い出し
  before_action :configure_permitted_parameters, if: :devise_controller? # Deviseのストロングパラメーターを許可

  def ensure_guest_user
    if user_signed_in? && current_user.guest_user?
      reset_session
      redirect_to new_user_session_path, alert: "ゲストユーザーはこの操作を実行できません。ログインするか会員登録してください。"
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :privacy])
  end

  private
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  def after_sign_out_path_for(resource_or_scope)
    if flash[:notice]&.include?("削除") || flash[:notice]&.include?("退会")
      new_user_registration_path
    else
      root_path
    end
  end
end