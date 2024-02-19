require 'rails_helper'

RSpec.describe DogsController, type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:valid_attributes) { { name: "DogName", birthday: "2023-01-01", sex: "male", breed: "BreedName" } }
  let(:invalid_attributes) { { name: "", birthday: "", sex: "", breed: "" } }
  let!(:dog) { create(:dog, user: user) }
  let!(:dog_to_destroy) { create(:dog, user: user) }

  before do
    sign_in user
  end

  describe "GET /new" do
    it "正常にレスポンスを返すこと" do
      get new_dog_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "POST /create" do
    context "パラメーターが有効な場合" do
      it "mypageへリダイレクトされること" do
        post dogs_path, params: { dog: valid_attributes }
        expect(response).to redirect_to(mypage_path)
      end
    end

    context "パラメーターが無効な場合" do
      it "'new'テンプレートがレンダリングされること" do
        post dogs_path, params: { dog: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "正常にレスポンスを返すこと" do
      get edit_dog_path(dog)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "PATCH /update" do
    context "パラメーターが有効な場合" do
      it "mypageへリダイレクトされること" do
        patch dog_path(dog), params: { dog: { name: "OtherName" } }
        expect(response).to redirect_to(mypage_path)
      end
    end

    context "パラメーターが無効な場合" do
      it "'edit'テンプレートがレンダリングされること" do
        patch dog_path(dog), params: { dog: { name: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "mypageへリダイレクトされること" do
      delete dog_path(dog_to_destroy)
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(mypage_path)
    end
  end
end
