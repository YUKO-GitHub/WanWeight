require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  # 存在性のバリデーション
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:birthday) }

  # 長さのバリデーション
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to validate_length_of(:introduction).is_at_most(50) }

  # 一意性のバリデーション
  describe 'email address uniqueness' do
    let!(:existing_user) { create(:user, email: 'example@example.com') }
    it 'is invalid with a duplicate email address' do
      user.email = 'example@example.com'
      expect(user).to_not be_valid
    end
    it 'is valid with a unique email address' do
      user.email = 'unique@example.com'
      expect(user).to be_valid
    end
  end

  # メールアドレスの小文字化
  it 'downcases email before saving' do
    user.email = 'EXAMPLE@EXAMPLE.COM'
    user.save!
    expect(user.reload.email).to eq('example@example.com')
  end

  # パスワードのバリデーション
  describe 'password validation' do
    it 'is invalid if password is present and not alphanumeric' do
      user.password = 'password'
      expect(user).to_not be_valid
    end
    it 'is valid with an alphanumeric password' do
      user.password = 'password123'
      expect(user).to be_valid
    end
  end

  # アソシエーション
  it { is_expected.to have_many(:dogs).dependent(:destroy) }
end
