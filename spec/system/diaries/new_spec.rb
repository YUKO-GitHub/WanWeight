require 'rails_helper'

RSpec.describe "Diaries", type: :system do
  let(:user) { create(:user) }
  let!(:dog) { create(:dog, user: user) }

  before do
    sign_in user
    visit new_diary_path
  end

  it '新規作成ページで日記を作成できること' do
    expect {
      select dog.name, from: '日記の対象'
      fill_in '日付', with: Date.current
      fill_in '出来事', with: '今日は公園で遊んだ'
      fill_in '食事', with: 'チキンとライス'
      fill_in '運動', with: '朝のジョギング'
      fill_in '健康', with: '体調良好'
      click_on '日記を作成'
    }.to change(Diary, :count).by(1)

    expect(current_path).to eq diaries_path
    expect(page).to have_content '今日は公園で遊んだ'
  end
end
