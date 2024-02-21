require 'rails_helper'

RSpec.describe "愛犬の体重一覧ページ", type: :system do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }
  let!(:dog_weights) { create(:dog_weight, dog: dog, date: Date.current) }

  before do
    sign_in user
    visit dog_dog_weights_path(dog)
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("愛犬の体重記録")
  end

  context "体重の記録が存在する場合" do
    it "記録された体重のグラフが表示されること" do
      expect(page).to have_css("script", text: "体重一覧", visible: false)
    end

    it "体重の一覧が表示されること" do
      expect(page).to have_content(dog_weights.date.to_fs(:custom_time))
      expect(page).to have_content("#{dog_weights.weight} kg")
      expect(page).to have_link('編集', href: edit_dog_dog_weight_path(dog, dog_weights))
      expect(page).to have_link('削除', href: dog_dog_weight_path(dog, dog_weights))
    end

    it "「編集」リンクをクリックすると、体重の編集ページに遷移すること" do
      find_link('編集').click
      expect(current_path).to eq edit_dog_dog_weight_path(dog, dog_weights)
    end

    it "「削除」リンクをクリックすると、体重のデータが削除されること" do
      find_link('削除').click
      expect(page).to have_content("愛犬の体重が正常に削除されました。")
    end
  end

  context "体重の記録が存在しない場合" do
    before do
      dog_weights.destroy
      visit dog_dog_weights_path(dog)
    end

    it "「体重の記録がありません」というメッセージが表示されること" do
      expect(page).to have_content("体重の記録がありません")
    end
  end
end
