require 'rails_helper'

RSpec.describe "日記一覧ページ", type: :system do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }
  let!(:diary) { create(:diary, user: user, dog: dog) }
  let!(:diary2) { create(:diary, user: user) }

  before do
    sign_in user
    visit diaries_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("日記一覧")
  end

  it '日記一覧ページが正しく表示されること' do
    expect(page).to have_content '日記一覧'
    expect(page).to have_link '日記を作成', href: new_diary_path
  end

  it '日記一覧に複数の日記が表示されること' do
    expect(page).to have_content diary.date.strftime('%-d')
    expect(page).to have_content diary2.date.strftime('%-d')
  end

  it '日記がない場合にメッセージが表示されること' do
    Diary.delete_all
    visit diaries_path
    expect(page).to have_content '日記がありません'
  end

  it '各日記に正しい情報が表示されること' do
    expect(page).to have_content diary.diary_text
    expect(page).to have_content diary2.diary_text
    expect(page).to have_content user.name
  end
end
