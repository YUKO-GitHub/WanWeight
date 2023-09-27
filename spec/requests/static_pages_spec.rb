require "rails_helper"

RSpec.describe "StaticPages", type: :request do
  describe "GET #home" do
    it "正常なレスポンスを返すこと" do
      get root_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #terms" do
    it "正常なレスポンスを返すこと" do
      get terms_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #privacy_policy" do
    it "正常なレスポンスを返すこと" do
      get privacy_policy_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
