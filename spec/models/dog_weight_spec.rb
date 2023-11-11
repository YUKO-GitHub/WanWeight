require 'rails_helper'

RSpec.describe DogWeight, type: :model do
  let(:dog_weight) { create(:dog_weight) }

  it 'Dogモデルと関連があること' do
    expect(dog_weight).to respond_to(:dog)
  end

  it '体重の入力がない場合は無効であること' do
    dog_weight.weight = nil
    expect(dog_weight).to_not be_valid
  end

  it '体重が150を超える場合は無効であること' do
    dog_weight.weight = 151
    expect(dog_weight).to_not be_valid
  end

  it '体重が数字でない場合は無効であること' do
    dog_weight.weight = 'abc'
    expect(dog_weight).to_not be_valid
  end

  it '日付がない場合は無効であること' do
    dog_weight.date = nil
    expect(dog_weight).to_not be_valid
  end
end
