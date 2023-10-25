require 'rails_helper'

RSpec.describe "静的ページ", type: :system do
  describe "home" do
    before do
      visit root_path
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title page_title('')
    end
  end

  describe "terms" do
    before do
      visit terms_path
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title page_title('利用規約')
    end
  end

  describe "privacy_policy" do
    before do
      visit privacy_policy_path
    end

    it "正しいタイトルが表示されること" do
      expect(page).to have_title page_title('プライバシーポリシー')
    end
  end
end
