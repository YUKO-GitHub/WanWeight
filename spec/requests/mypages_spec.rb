require 'rails_helper'

RSpec.describe "MypagesController", type: :request do
  let(:user) { create(:user) }
  let!(:user_weight) { create(:user_weight, user: user) }
  let!(:dog) { create(:dog, user: user) }

  describe "GET /show" do
    context "ログイン済みの場合" do
      before do
        sign_in user
        get mypage_path
      end

      it "正常にレスポンスを返すこと" do
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end

      it "愛犬情報がレスポンスに含まれていること" do
        expect(response.body).to include dog.name
        expect(response.body).to include dog.birthday.strftime('%Y-%m-%d')
        expect(response.body).to include I18n.t("activerecord.enums.dog.sex.#{dog.sex}")
        expect(response.body).to include dog.breed if dog.breed.present?
      end

      it "体重記録がレスポンスに含まれていること" do
        expect(response.body).to include user_weight.weight.to_s
        expect(response.body).to include user_weight.date.to_fs(:custom_datetime)
      end
    end

    context "未ログインの場合" do
      before do
        get mypage_path
      end

      it "ログインページへリダイレクトされること" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
