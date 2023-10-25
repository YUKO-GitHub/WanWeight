require 'rails_helper'

RSpec.describe "愛犬編集ページ", type: :system do
  let(:user) { create(:user) }
  let!(:dog) { create(:dog, user: user) }

  before do
    sign_in user
    visit edit_dog_path(dog)
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("愛犬編集")
  end

  it "有効な愛犬情報で編集できること" do
    fill_in "名前", with: "ポンタ"
    select "2023", from: "dog_birthday_1i"
    select "01", from: "dog_birthday_2i"
    select "01", from: "dog_birthday_3i"
    select "女の子", from: "dog_sex"
    fill_in "犬種", with: "柴犬"
    click_button "変更を保存"

    expect(current_path).to eq mypage_path
    expect(page).to have_content "更新しました"
  end

  it "無効な愛犬情報では編集できないこと" do
    fill_in "名前", with: ""
    click_button "変更を保存"

    expect(page).to have_content "名前を入力してください"
  end
end
