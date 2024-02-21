require 'rails_helper'

RSpec.describe "日記詳細ページ", type: :system do
  let(:user) { create(:user) }
  let!(:dog) { create(:dog, user: user) }
  let!(:diary) { create(:diary, user: user, dog: dog) }

  before do
    sign_in user
    visit diary_path(diary)
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("#{@diary_title}の日記")
  end

  it '詳細ページに日記の内容が表示されること' do
    expect(page).to have_content diary.diary_text
    expect(page).to have_content diary.meal_text
    expect(page).to have_content diary.exercise_text
    expect(page).to have_content diary.health_text

    if diary.photos.attached?
      expect(page).to have_css("img")
    end

    expect(page).to have_link '編集', href: edit_diary_path(diary)
    expect(page).to have_link '削除', href: diary_path(diary)
  end
end
