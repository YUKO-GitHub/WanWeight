require 'rails_helper'

RSpec.describe "アカウント編集", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit edit_user_registration_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("アカウント編集")
  end

  it 'アカウント情報を編集できること' do
    expect(page).to have_content('アカウント編集')

    fill_in 'メールアドレス', with: 'new_email@example.com'
    fill_in '現在のパスワード', with: user.password
    fill_in '変更後パスワード(変更する場合)', with: 'newpassword123'
    fill_in '確認用パスワード', with: 'newpassword123'

    click_button '更新'

    expect(page).to have_content('正常に更新されました。')
    expect(current_path).to eq user_path
  end

  it '無効な情報ではアカウント情報を編集できないこと' do
    expect(page).to have_content('アカウント編集')

    fill_in 'メールアドレス', with: ''
    fill_in '現在のパスワード', with: ''

    click_button '更新'

    expect(page).to have_content('メールアドレスを入力してください')
    expect(page).to have_content('現在のパスワードを入力してください')
  end
end
