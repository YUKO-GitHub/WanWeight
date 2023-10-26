require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  describe "GET /account" do
    it "正常なレスポンスを返すこと" do
      sign_in create(:user)
      get user_path
      expect(response).to have_http_status(:success)
    end
  end
end
