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
end
