require 'rails_helper'

RSpec.describe DogWeightsController, type: :request do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }
  let(:valid_attributes) { { weight: 10.5, date_part: '2023-01-01', time_part: '12:00' } }
  let(:invalid_attributes) { { weight: nil, date_part: nil, time_part: nil } }
  let!(:dog_weight) { create(:dog_weight, dog: dog) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "正常にレスポンスを返すこと" do
      get dog_dog_weights_path(dog)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "GET /new" do
    it "正常にレスポンスを返すこと" do
      get new_dog_dog_weight_path(dog)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "POST /create" do
    context "パラメータが有効な場合" do
      it "マイページへリダイレクトされること" do
        post dog_dog_weights_path(dog), params: { dog_weight: valid_attributes }
        expect(response).to redirect_to(mypage_path)
      end
    end

    context "パラメータが無効な場合" do
      it "'new'テンプレートがレンダリングされること" do
        post dog_dog_weights_path(dog), params: { dog_weight: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "正常にレスポンスを返すこと" do
      get edit_dog_dog_weight_path(dog, dog_weight)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "PATCH /update" do
    context "パラメータが有効な場合" do
      it "一覧ページへリダイレクトされること" do
        patch dog_dog_weight_path(dog, dog_weight), params: { dog_weight: valid_attributes }
        expect(response).to redirect_to(dog_dog_weights_path(dog))
      end
    end

    context "パラメータが無効な場合" do
      it "'edit'テンプレートがレンダリングされること" do
        patch dog_dog_weight_path(dog, dog_weight), params: { dog_weight: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "一覧ページへリダイレクトされること" do
      delete dog_dog_weight_path(dog, dog_weight)
      expect(response).to redirect_to(dog_dog_weights_path(dog))
    end
  end
end
