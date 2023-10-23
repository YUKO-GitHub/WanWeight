require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  before do
    visit new_user_registration_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("新規登録")
  end

  it "正しい要素が表示されていること" do
    expect(page).to have_content("新規登録")
    expect(page).to have_selector("label", text: "* ユーザー名")
    expect(page).to have_selector("label", text: "* 生年月日")
    expect(page).to have_selector("label", text: "* メールアドレス")
    expect(page).to have_selector("label", text: "* パスワード")
    expect(page).to have_selector("label", text: "* 確認用パスワード")
  end

  it "有効なユーザー情報で新規登録できること" do
    fill_in "* ユーザー名", with: "Test User"
    select "2000", from: "user_birthday_1i"
    select "01", from: "user_birthday_2i"
    select "01", from: "user_birthday_3i"
    fill_in "* メールアドレス", with: "test@example.com"
    fill_in "* パスワード", with: "password123"
    fill_in "* 確認用パスワード", with: "password123"

    expect { click_button "新しいアカウントを作成" }.to change(User, :count).by(1)
    expect(current_path).to eq mypage_path
  end

  it "無効なユーザー情報では新規登録できないこと" do
    fill_in "* メールアドレス", with: ""
    click_button "新しいアカウントを作成"

    expect(page).to have_content("メールアドレスを入力してください")
    expect(User.count).to eq 0
  end
end
