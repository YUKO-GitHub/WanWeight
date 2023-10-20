# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    mypage_path
  end

  def after_update_path_for(resource)
    user_path(id: current_user.id)
  end

  def after_destroy_path_for(resource)
    root_path
  end
end
