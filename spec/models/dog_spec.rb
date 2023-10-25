require 'rails_helper'

RSpec.describe Dog, type: :model do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }

  it '名前がなければ無効な状態であること' do
    dog.name = nil
    expect(dog).to_not be_valid
    expect(dog.errors[:name]).to include("を入力してください")
  end

  it '誕生日がなければ無効な状態であること' do
    dog.birthday = nil
    expect(dog).to_not be_valid
    expect(dog.errors[:birthday]).to include("を入力してください")
  end

  it '性別が[unselected, female, male]のいずれかであること' do
    expect(Dog.sexes.keys).to include(dog.sex)
  end

  it 'ユーザーと関連があること' do
    expect(dog.user_id).to eq(user.id)
  end
end
