require 'rails_helper'

RSpec.describe "RegistrationsControllerEdit", type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, email: "") }

  before do
    sign_in user
  end

  describe "GET /edit_account" do
    it "正常にレスポンスを返すこと" do
      get edit_user_registration_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "PATCH /edit_account" do
    context "パラメーターが有効な場合" do
      it "アカウント情報を更新できること" do
        valid_params = user_params.merge(current_password: user.password)
        patch update_user_registration_path, params: { user: valid_params }
        expect(response).to redirect_to user_path(id: user.id)
        follow_redirect!
        expect(response.body).to include("正常に更新されました。")
      end
    end

    context "パラメーターが無効な場合" do
      it "アカウント情報を更新できないこと" do
        patch update_user_registration_path, params: { user: invalid_user_params }
        expect(response.body).to include("メールアドレスを入力してください")
      end
    end
  end

  describe "DELETE /delete_account" do
    it "アカウントを削除できること" do
      expect do
        delete delete_user_registration_path
      end.to change(User, :count).by(-1)
      expect(response).to redirect_to root_path
      follow_redirect!
      expect(response.body).to include("アカウントは正常に削除されました。")
    end
  end
end
