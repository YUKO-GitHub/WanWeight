require 'rails_helper'

RSpec.describe "ProfilesController", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /profiles" do
    it "正常なレスポンスを返すこと" do
      get profiles_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
