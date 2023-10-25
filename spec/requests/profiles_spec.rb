require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /profiles" do
    it "正常なレスポンスを返すこと" do
      sign_in create(:user)
      get profiles_path
      expect(response).to have_http_status(:success)
    end
  end
end
