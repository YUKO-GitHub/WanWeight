require 'rails_helper'

RSpec.describe "DiariesController", type: :request do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }
  let(:diary_attributes) { attributes_for(:diary, user_id: user.id, dog_id: dog.id) }
  let(:long_text) { 'a' * 1001 }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "日記一覧ページへのアクセスが成功すること" do
      get diaries_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "新規作成ページへのアクセスが成功すること" do
      get new_diary_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "パラメーターが有効な場合" do
      it "日記の作成に成功し、リダイレクトすること" do
        expect {
          post diaries_path, params: { diary: diary_attributes }
        }.to change(Diary, :count).by(1)
        expect(response).to redirect_to(diaries_path)
      end
    end

    context "パラメーターが無効な場合" do
      it "日記の作成に失敗し、再度新規作成ページをレンダリングすること" do
        expect {
          post diaries_path, params: { diary: diary_attributes.merge(diary_text: long_text) }
        }.to_not change(Diary, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /show" do
    it "詳細ページへのアクセスが成功すること" do
      diary = create(:diary, user: user, dog: dog)
      get diary_path(diary)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "編集ページへのアクセスが成功すること" do
      diary = create(:diary, user: user, dog: dog)
      get edit_diary_path(diary)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /update" do
    let(:diary) { create(:diary, user: user, dog: dog) }

    context "パラメーターが有効な場合" do
      it "日記の更新に成功し、リダイレクトすること" do
        patch diary_path(diary), params: { diary: { diary_text: "Updated text", new_photos: [] } }
        expect(response).to redirect_to(diaries_path)
        diary.reload
        expect(diary.diary_text).to eq "Updated text"
      end
    end

    context "パラメーターが無効な場合" do
      it "日記の更新に失敗し、再度編集ページをレンダリングすること" do
        patch diary_path(diary), params: { diary: { diary_text: long_text } }
        expect(response).to have_http_status(:unprocessable_entity)
        diary.reload
        expect(diary.diary_text).to_not eq long_text
      end
    end
  end

  describe "DELETE /destroy" do
    it "日記の削除に成功し、リダイレクトすること" do
      diary = create(:diary, user: user, dog: dog)
      expect {
        delete diary_path(diary)
      }.to change(Diary, :count).by(-1)
      expect(response).to redirect_to(diaries_path)
    end
  end
end
