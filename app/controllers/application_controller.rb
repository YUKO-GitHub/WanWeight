class ApplicationController < ActionController::Base
  before_action :set_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def set_user
    @user = current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthday, :height, :introduction, :profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :birthday, :height, :introduction, :profile_image])
  end
end
