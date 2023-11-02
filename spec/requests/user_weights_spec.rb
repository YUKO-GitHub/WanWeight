require 'rails_helper'

RSpec.describe "UserWeightsController", type: :request do
  let(:user) { create(:user) }
  let!(:user_weight) { create(:user_weight, user: user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "正常なレスポンスを返すこと" do
      get user_weights_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "パラメーターが有効な場合" do
      let(:valid_params) do
        {
          user_weight: {
            weight: rand(50..100).to_f,
            date_part: Faker::Date.between(from: Date.current.beginning_of_month, to: Date.current.end_of_month).to_s,
            time_part: '12:00:00',
          },
        }
      end

      it "新しい体重記録を作成すること" do
        expect do
          post user_weights_path, params: valid_params
        end.to change(UserWeight, :count).by(1)
      end

      it "マイページにリダイレクトすること" do
        post user_weights_path, params: valid_params
        expect(response).to redirect_to(mypage_path)
      end
    end

    context "パラメーターが無効な場合" do
      let(:invalid_params) do
        {
          user_weight: {
            weight: nil,
            date_part: Faker::Date.between(from: Date.current.beginning_of_month, to: Date.current.end_of_month).to_s,
            time_part: '12:00:00',  # あるいは適切な時間を設定してください
          },
        }
      end

      it "新しい体重記録を作成しないこと" do
        expect do
          post user_weights_path, params: invalid_params
        end.not_to change(UserWeight, :count)
      end

      it "HTTPのエラーコード422を返すこと" do
        post user_weights_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "パラメーターが有効な場合" do
      let(:new_weight) { 65.0 }
      let(:valid_params) do
        {
          user_weight: {
            weight: new_weight,
            date_part: Faker::Date.between(from: Date.current.beginning_of_month, to: Date.current.end_of_month).to_s,
            time_part: '12:00:00',
          },
        }
      end

      it "体重記録を更新すること" do
        patch user_weight_path(user_weight), params: valid_params
        expect(user_weight.reload.weight).to eq(new_weight)
      end

      it "体重の一覧ページにリダイレクトすること" do
        patch user_weight_path(user_weight), params: valid_params
        expect(response).to redirect_to(user_weights_path)
      end
    end

    context "パラメーターが無効な場合" do
      let(:invalid_params) do
        {
          user_weight: {
            weight: nil,
            date_part: Faker::Date.between(from: Date.current.beginning_of_month, to: Date.current.end_of_month).to_s,
            time_part: '12:00:00',
          },
        }
      end

      it "体重記録を更新しないこと" do
        original_weight = user_weight.weight
        patch user_weight_path(user_weight), params: invalid_params
        expect(user_weight.reload.weight).to eq(original_weight)
      end

      it "HTTPのエラーコード422を返すこと" do
        patch user_weight_path(user_weight), params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "体重記録を削除すること" do
      expect do
        delete user_weight_path(user_weight)
      end.to change(UserWeight, :count).by(-1)
    end

    it "体重の一覧ページにリダイレクトすること" do
      delete user_weight_path(user_weight)
      expect(response).to redirect_to(user_weights_path)
    end
  end
end
