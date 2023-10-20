# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  protected

  def after_sign_in_path_for(resource)
    mypage_path
  end
end
