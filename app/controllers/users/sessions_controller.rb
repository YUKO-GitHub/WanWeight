# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :downcase_email, only: :create

  def guest_sign_in
    user = User.find_by(email: 'guest@example.com')
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  def downcase_email
    if params[:user]
      if params[:user][:email]
        params[:user][:email] = params[:user][:email].downcase
      end
    end
  end

  def after_sign_in_path_for(resource)
    mypage_path
  end
end
