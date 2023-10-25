require 'rails_helper'

RSpec.describe "DeviseRegistrationsNew", type: :request do
  describe "GET /sign_up" do
    it "正常なレスポンスを返すこと" do
      get new_user_registration_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "POST /sign_up" do
    let(:user_params) do
      {
        name: "Example User",
        birthday: "2000-01-01",
        email: "user@example.com",
        password: "password123",
        password_confirmation: "password123",
      }
    end

    context "パラメーターが有効な場合" do
      it "新規ユーザーを作成し、マイページへリダイレクトすること" do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to change(User, :count).by(1)

        expect(response).to redirect_to(mypage_path)
      end
    end

    context "パラメーターが無効な場合" do
      it "新規ユーザーは作成せず、新規登録のページを表示すること" do
        user_params[:email] = ''

        expect do
          post user_registration_path, params: { user: user_params }
        end.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
