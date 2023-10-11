# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  
    if update_resource(resource, account_update_params)
      redirect_to user_path(resource), notice: "ユーザー情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  protected

  def after_sign_up_path_for(resource)
    mypage_path(resource)
  end
end
