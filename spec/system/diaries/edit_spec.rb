require 'rails_helper'

RSpec.describe "日記編集ページ", type: :system do
  let(:user) { create(:user) }
  let!(:dog) { create(:dog, user: user) }
  let!(:diary) { create(:diary, user: user, dog: dog) }

  before do
    sign_in user
    visit edit_diary_path(diary)
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("日記編集")
  end

  it '編集ページで日記を編集できること' do
    expect(page).to have_content '日記を編集する'

    fill_in '出来事', with: '今日は遊園地で遊んだ'
    click_on '日記を更新'

    expect(current_path).to eq diaries_path
    expect(page).to have_content '今日は遊園地で遊んだ'
  end

  it "日記一覧ページに戻ること" do
    click_link "キャンセル"
    expect(page).to have_current_path(diaries_path)
  end
end
