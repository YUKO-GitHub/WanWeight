require 'rails_helper'

RSpec.describe UserWeight, type: :model do
  let(:user_weight) { create(:user_weight) }

  it 'Userモデルと関連があること' do
    expect(user_weight).to respond_to(:user)
  end

  it '体重の入力がない場合は無効であること' do
    user_weight.weight = nil
    expect(user_weight).to_not be_valid
  end

  it '体重が200を超える場合は無効であること' do
    user_weight.weight = 201
    expect(user_weight).to_not be_valid
  end

  it '体重が数字でない場合は無効であること' do
    user_weight.weight = 'abc'
    expect(user_weight).to_not be_valid
  end

  it '日付がない場合は無効であること' do
    user_weight.date = nil
    expect(user_weight).to_not be_valid
  end
end
