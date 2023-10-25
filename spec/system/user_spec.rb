require 'rails_helper'

RSpec.describe "アカウントページ", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit user_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title('アカウント')
  end

  it "アカウントページが正常に表示されること" do
    expect(page).to have_content "アカウント"
    expect(page).to have_content user.email
    expect(page).to have_content "*********"
  end

  it "「編集」リンクをクリックすると、ユーザー編集ページに遷移すること" do
    click_link "編集"
    expect(current_path).to eq edit_user_registration_path
  end

  it "「アカウント削除」をクリックすると、アカウントが削除されること", js: true do
    click_link "アカウント削除"
    expect(page).to have_content "アカウントは正常に削除されました。"
    expect(User.exists?(user.id)).to be_falsey
  end
end
