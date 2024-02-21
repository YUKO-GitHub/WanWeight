require 'rails_helper'

RSpec.describe "愛犬の体重編集ページ", type: :system do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }
  let!(:dog_weight) { create(:dog_weight, dog: dog) }

  before do
    sign_in user
    visit edit_dog_dog_weight_path(dog, dog_weight)
  end

  it "正しいタイトルが表示されること" do
    expect(page).to have_title page_title("愛犬の体重編集")
  end

  it "ページが正しく表示されること" do
    expect(page).to have_content "#{dog.name}の体重を編集する"
    expect(page).to have_selector "input[name='dog_weight[date_part]']"
    expect(page).to have_selector "input[name='dog_weight[time_part]']"
    expect(page).to have_selector "input[name='dog_weight[weight]']"
    expect(page).to have_selector "input[type='submit']"
  end

  it "有効な情報で編集できること" do
    fill_in "dog_weight[weight]", with: "12.0"
    click_button "更新"

    expect(page).to have_content "愛犬の体重が正常に更新されました。"
    expect(current_path).to eq dog_dog_weights_path(dog)
    expect(dog_weight.reload.weight).to eq 12.0
  end

  it "無効な情報では編集できないこと" do
    fill_in "dog_weight[weight]", with: ""

    click_button "更新"

    expect(page).to have_content "を入力してください"
  end
end
