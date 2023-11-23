# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: [:update, :destroy]

  def after_sign_up_path_for(resource)
    mypage_path
  end

  def after_update_path_for(resource)
    user_path(id: current_user.id)
  end

  def after_destroy_path_for(resource)
    root_path
  end

  private

  def check_guest
    if current_user.email == 'guest@example.com'
      redirect_to mypage_path, alert: 'ゲストユーザーのアカウント情報は変更または削除できません。'
    end
  end
end
