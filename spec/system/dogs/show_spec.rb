require 'rails_helper'

RSpec.describe "マイページ", type: :system do
  let(:user) { create(:user) }
  let!(:dog) { create(:dog, user: user) }

  before do
    sign_in user
    visit mypage_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title('マイページ')
  end

  context "愛犬が登録されていない場合" do
    let!(:dog) { nil }

    it "「愛犬を登録する」リンクが表示されること" do
      expect(page).to have_content "まだ愛犬は登録されていません。"
      expect(page).to have_link "愛犬を登録する", href: new_dog_path
    end
  end

  context "愛犬が登録されている場合" do
    it "愛犬のプロフィールカードが表示されること" do
      expect(page).to have_content dog.name
      expect(page).to have_content dog.birthday
      expect(page).to have_content I18n.t("activerecord.enums.dog.sex.#{dog.sex}")
      expect(page).to have_content dog.breed if dog.breed.present?
      expect(page).to have_link "編集", href: edit_dog_path(dog)
      expect(page).to have_link "削除", href: dog_path(dog)
    end
  end
end
