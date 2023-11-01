require 'rails_helper'

RSpec.describe "ユーザー体重記録ページ", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit new_user_weight_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("ユーザー体重記録")
  end

  it "ページが正しく表示されること" do
    expect(page).to have_content "体重を記録する"
    expect(page).to have_selector "input[name='user_weight[date_part]']"
    expect(page).to have_selector "input[name='user_weight[time_part]']"
    expect(page).to have_selector "input[name='user_weight[weight]']"
    expect(page).to have_selector "input[type='submit']"
  end

  it "正常に体重を記録できること" do
    fill_in "user_weight[date_part]", with: Date.current.strftime("%Y-%m-%d")
    fill_in "user_weight[time_part]", with: Time.current.strftime("%H:%M")
    fill_in "体重", with: "65.5"

    click_button "保存"

    expect(page).to have_content "体重が正常に記録されました"
    expect(page).to have_current_path(mypage_path)
  end

  it "エラーメッセージを表示すること" do
    fill_in "user_weight[date_part]", with: Date.current.strftime("%Y-%m-%d")
    fill_in "user_weight[time_part]", with: Time.current.strftime("%H:%M")
    click_button "保存"

    expect(page).to have_content "を入力してください"
  end

  it "マイページに戻ること" do
    click_link "キャンセル"
    expect(page).to have_current_path(mypage_path)
  end
end
