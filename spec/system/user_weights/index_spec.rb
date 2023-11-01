require 'rails_helper'

RSpec.describe "体重の記録ページ", type: :system do
  let(:user) { create(:user) }
  let!(:user_weights) { create(:user_weight, user: user) }

  before do
    sign_in user
    visit user_weights_path
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title('体重の記録')
  end

  context "体重の記録が存在する場合" do
    it "記録された体重のグラフが表示されること" do
      expect(page).to have_css("script", text: "体重一覧", visible: false)
    end

    it "体重の一覧が表示されること" do
      expect(page).to have_content(user_weights.date.to_fs(:custom_datetime))
      expect(page).to have_content("#{user_weights.weight} kg")
      expect(page).to have_link('編集', href: edit_user_weight_path(user_weights))
      expect(page).to have_link('削除', href: user_weight_path(user_weights))
    end

    it "「編集」リンクをクリックすると、体重の編集ページに遷移すること" do
      find_link('編集').click
      expect(current_path).to eq edit_user_weight_path(user_weights)
    end

    it "「削除」リンクをクリックすると、体重のデータが削除されること" do
      find_link('削除').click
      expect(page).to have_content("体重が正常に削除されました。")
    end
  end

  context "体重の記録が存在しない場合" do
    before do
      user_weights.destroy
      visit user_weights_path
    end

    it "「体重の記録がありません」というメッセージが表示されること" do
      expect(page).to have_content("体重の記録がありません")
    end
  end  
end
