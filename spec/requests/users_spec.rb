require 'rails_helper'

RSpec.describe "UsersController", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /account" do
    it "正常にレスポンスを返すこと" do
      get user_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
