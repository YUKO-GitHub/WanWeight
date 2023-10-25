require 'rails_helper'

RSpec.describe "愛犬登録ページ", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit new_dog_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("愛犬登録")
  end

  it "ページが正しく表示されること" do
    expect(page).to have_content "愛犬を登録する"
    expect(page).to have_selector "input[name='dog[name]']"
    expect(page).to have_selector "select[name='dog[birthday(1i)]']"
    expect(page).to have_selector "select[name='dog[sex]']"
    expect(page).to have_selector "input[name='dog[breed]']"
    expect(page).to have_selector "input[type='submit']"
  end

  it "有効な愛犬情報で新規登録できること" do
    fill_in "dog[name]", with: "ポチ"
    select "2021", from: "dog_birthday_1i"
    select "01", from: "dog_birthday_2i"
    select "01", from: "dog_birthday_3i"
    select "男の子", from: "dog_sex"
    fill_in "dog[breed]", with: "シーズー"
    click_button "愛犬を登録"

    expect(current_path).to eq mypage_path
    expect(page).to have_content "愛犬を登録しました"
    expect(page).to have_content "ポチ"
  end

  it "無効な愛犬情報では新規登録できないこと" do
    fill_in "dog[name]", with: ""
    click_button "愛犬を登録"

    expect(page).to have_content "名前を入力してください"
  end
end
