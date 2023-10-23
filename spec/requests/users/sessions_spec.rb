require 'rails_helper'

RSpec.describe "UsersSessions", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) { { user: { email: user.email, password: user.password } } }
  let(:invalid_attributes) { { user: { email: "", password: "" } } }

  describe "GET /new" do
    it "正常なレスポンスを返すこと" do
      get new_user_session_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "POST /create" do
    context "パラメーターが有効な場合" do
      it "ログインできること" do
        post user_session_path, params: valid_attributes
        expect(response).to redirect_to mypage_path
      end
    end

    context "パラメーターが無効な場合" do
      it "ログインできないこと" do
        post user_session_path, params: invalid_attributes
        expect(response.body).to include("無効なメールアドレスまたはパスワード。")
      end
    end
  end

  describe "DELETE /destroy" do
    it "ログアウトできること" do
      sign_in user
      delete destroy_user_session_path
      expect(response).to redirect_to root_path
    end
  end
end
