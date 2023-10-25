require 'rails_helper'

RSpec.describe "Mypages", type: :request do
  let(:user) { create(:user) }
  let!(:dog) { create(:dog, user: user) }

  describe "GET /show" do
    before do
      sign_in user
      get mypage_path
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    it "愛犬情報が表示されていること" do
      expect(response.body).to include dog.name
      expect(response.body).to include dog.birthday.strftime('%Y-%m-%d')
      expect(response.body).to include I18n.t("activerecord.enums.dog.sex.#{dog.sex}")
      expect(response.body).to include dog.breed if dog.breed.present?
    end
  end
end
