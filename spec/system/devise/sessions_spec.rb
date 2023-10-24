require 'rails_helper'

RSpec.describe 'ログインページ', type: :system do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title('ログイン')
  end

  it '正しい要素が表示されること' do
    expect(page).to have_content('ログイン')
    expect(page).to have_selector('label', text: 'メールアドレス')
    expect(page).to have_selector('label', text: 'パスワード')
    expect(page).to have_selector('input[name="commit"]')
  end

  it "ログインフォームが正しく表示されること" do
    expect(page).to have_css 'input#user_email'
    expect(page).to have_css 'input#user_password'
  end

  it "ログインボタンが表示されること" do
    expect(page).to have_button 'ログイン'
  end

  it '「新しくアカウントを作成する」リンクが正しく動作すること' do
    click_link '新しくアカウントを作成する'
    expect(current_path).to eq new_user_registration_path
  end

  it '有効な情報でログインできること' do
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    expect(current_path).to eq mypage_path
    expect(page).to have_content 'ログインしました。'
  end

  it '無効な情報ではログインできないこと' do
    visit new_user_session_path
    fill_in 'メールアドレス', with: ''
    fill_in 'パスワード', with: ''
    click_button 'ログイン'
    expect(page).to have_content('無効なメールアドレスまたはパスワード。')
  end
end
