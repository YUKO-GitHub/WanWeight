require 'rails_helper'

RSpec.describe "プロフィールページ", type: :system do
  let(:user) { create(:user) }
  let!(:avatar) { fixture_file_upload(Rails.root.join('spec/fixtures/files/sample_user.jpg'), 'image/jpeg') }

  before do
    sign_in user
    user.avatar.attach(avatar)
    visit profiles_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title('プロフィール')
  end

  it "ユーザー情報が正しく表示されること" do
    expect(page).to have_content "プロフィール"
    within "turbo-frame#profile" do
      expect(page).to have_content user.name
      expect(page).to have_content user.birthday
      expect(page).to have_content user.introduction
      expect(page).to have_link "編集", href: profiles_edit_path
    end
  end

  it "プロフィール画像が表示されること" do
    expect(page).to have_selector("img[src$='sample_user.jpg']")
  end

  it "「編集」リンクをクリックするとプロフィール編集ページに遷移すること" do
    within "turbo-frame#profile" do
      click_link "編集"
    end
    expect(current_path).to eq profiles_edit_path
  end
end
