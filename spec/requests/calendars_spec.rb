require 'rails_helper'

RSpec.describe "Calendars", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /show" do
    it "正常にレスポンスを返すこと" do
      get calendar_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
