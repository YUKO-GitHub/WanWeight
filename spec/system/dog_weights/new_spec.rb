require 'rails_helper'

RSpec.describe "愛犬の体重記録ページ", type: :system do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }

  before do
    sign_in user
    visit new_dog_dog_weight_path(dog)
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("愛犬の体重記録")
  end

  it "ページが正しく表示されること" do
    expect(page).to have_content "#{dog.name}の体重を記録する"
    expect(page).to have_selector "input[name='dog_weight[date_part]']"
    expect(page).to have_selector "input[name='dog_weight[time_part]']"
    expect(page).to have_selector "input[name='dog_weight[weight]']"
    expect(page).to have_selector "input[type='submit']"
  end

  it "有効な情報で新規登録できること" do
    fill_in "dog_weight[date_part]", with: Date.current.strftime("%Y-%m-%d")
    fill_in "dog_weight[time_part]", with: Time.current.strftime("%H:%M")
    fill_in "体重", with: "10.5"

    click_button "保存"

    expect(page).to have_content "愛犬の体重が正常に記録されました"
    expect(page).to have_current_path(mypage_path)
  end

  it "無効な情報では新規登録できないこと" do
    fill_in "dog_weight[date_part]", with: Date.current.strftime("%Y-%m-%d")
    fill_in "dog_weight[time_part]", with: Time.current.strftime("%H:%M")
    click_button "保存"

    expect(page).to have_content "を入力してください"
  end

  it "マイページに戻ること" do
    click_link "キャンセル"
    expect(page).to have_current_path(mypage_path)
  end
end
