require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it '名前が空欄だと無効であること' do
      user.name = nil
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("を入力してください")
    end

    it '誕生日が空欄だと無効であること' do
      user.birthday = nil
      expect(user).to_not be_valid
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    it '名前の長さに制限があること' do
      user.name = 'a' * 51
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include('は50文字以内で入力してください')
    end

    it 'メールアドレスの長さに制限があること' do
      user.email = 'a' * 244 + '@example.com'
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('は255文字以内で入力してください')
    end

    it '自己紹介の長さに制限があること' do
      user.introduction = 'a' * 51
      expect(user).to_not be_valid
      expect(user.errors[:introduction]).to include('は50文字以内で入力してください')
    end

    it 'メールアドレスが重複しないこと' do
      user1 = create(:user, email: 'test@example.com')
      user2 = build(:user, email: 'test@example.com')
      expect(user2).to_not be_valid
      expect(user2.errors[:email]).to include('はすでに存在します')
    end

    it 'パスワードの入力に制限があること' do
      user.password = 'password'
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('は半角英数を両方含む必要があります')
    end
  end

  describe 'callbacks' do
    it 'メールアドレスは小文字に変換してからDBに登録すること' do
      user.email = 'EXAMPLE@EXAMPLE.COM'
      user.save!
      expect(user.reload.email).to eq('example@example.com')
    end
  end

  describe 'associations' do
    it 'ユーザーは複数のDogと関連があること' do
      dog1 = create(:dog, user: user)
      dog2 = create(:dog, user: user)
      expect(user.dogs).to include(dog1, dog2)
    end
  end
end
