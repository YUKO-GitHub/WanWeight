require 'rails_helper'

RSpec.describe "マイページ", type: :system do
  let(:user) { create(:user) }
  let!(:user_weight) { create(:user_weight, user: user) }
  let!(:dog) { create(:dog, user: user) }
  let(:avatar) { fixture_file_upload(Rails.root.join('spec/fixtures/files/sample_user.jpg'), 'image/jpeg') }
  let(:dog_avatar) { fixture_file_upload(Rails.root.join('spec/fixtures/files/sample_dog.jpg'), 'image/jpeg') }

  before do
    sign_in user
    user.avatar.attach(avatar)
    visit mypage_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title('マイページ')
  end

  it "プロフィール画像が表示されること" do
    expect(page).to have_selector("img[src$='sample_user.jpg']")
  end

  context "ユーザーの体重記録が存在する場合" do
    it "最新の体重記録が表示されること" do
      expect(page).to have_content "前回の記録: #{user_weight.weight} kg"
      expect(page).to have_content "#{user_weight.date.to_fs(:custom_datetime)}"
    end

    it "「体重を記録」と「体重を管理」のリンクが表示されること" do
      expect(page).to have_link '体重を記録', href: new_user_weight_path
      expect(page).to have_link '体重を管理', href: user_weights_path
    end

    it "体重のグラフが表示されること" do
      expect(page).to have_css("script", text: "直近1ヶ月の体重推移", visible: false)
    end
  end

  context "ユーザーの体重記録が存在しない場合" do
    let!(:user_weight) { nil }

    it "体重の記録がないというメッセージが表示されること" do
      expect(page).to have_content "体重の記録がありません"
    end

    it "体重のグラフが表示されないこと" do
      expect(page).to_not have_css("script", text: "直近1ヶ月の体重推移", visible: false)
    end
  end

  context "愛犬が登録されていない場合" do
    let!(:dog) { nil }

    it "「愛犬を登録する」リンクが表示されること" do
      expect(page).to have_content "まだ愛犬は登録されていません。"
      expect(page).to have_link "愛犬を登録する", href: new_dog_path
    end
  end

  context "愛犬が登録されている場合" do
    before do
      dog.avatar.attach(dog_avatar)
      visit mypage_path
    end

    it "愛犬のプロフィールカードが表示されること" do
      expect(page).to have_content dog.name
      expect(page).to have_content dog.birthday
      expect(page).to have_content I18n.t("activerecord.enums.dog.sex.#{dog.sex}")
      expect(page).to have_content dog.breed if dog.breed.present?
      expect(page).to have_link "編集", href: edit_dog_path(dog)
      expect(page).to have_link "削除", href: dog_path(dog)
    end

    it "愛犬のプロフィール画像が表示されること" do
      expect(page).to have_selector("img[src$='sample_dog.jpg']")
    end
  end
end
