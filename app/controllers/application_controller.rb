class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :search_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:icon, :name, :email, :introduction,
                                                                :password, :password_confirmation])
    end

  private
    # ユーザーのログインを確認する
    def logged_in_user
      unless user_signed_in?
        redirect_to root_path
      end
    end
end
