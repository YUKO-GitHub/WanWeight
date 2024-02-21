require 'rails_helper'

RSpec.describe "ユーザー体重編集ページ", type: :system do
  let(:user) { create(:user) }
  let!(:user_weight) { create(:user_weight, user: user) }

  before do
    sign_in user
    visit edit_user_weight_path(user_weight)
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("ユーザー体重編集")
  end

  it "ページが正しく表示されること" do
    expect(page).to have_content "体重を編集する"
    expect(page).to have_selector "input[name='user_weight[date_part]']"
    expect(page).to have_selector "input[name='user_weight[time_part]']"
    expect(page).to have_selector "input[name='user_weight[weight]']"
    expect(page).to have_selector "input[type='submit']"
  end

  it "有効な情報で編集できること" do
    fill_in "user_weight[weight]", with: "65.0"
    click_button "更新"

    expect(page).to have_content "体重が正常に更新されました。"
    expect(current_path).to eq user_weights_path
    expect(user_weight.reload.weight).to eq 65.0
  end

  it "無効な情報では編集できないこと" do
    fill_in "user_weight[weight]", with: ""

    click_button "更新"

    expect(page).to have_content "を入力してください"
  end
end
