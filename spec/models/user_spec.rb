require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:large_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/large_avatar.jpg'), 'image/jpeg') }
  let(:invalid_format_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/invalid_avatar.svg'), 'image/svg') }

  it '名前がなければ無効な状態であること' do
    user.name = nil
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include("を入力してください")
  end

  it '誕生日がなければ無効な状態であること' do
    user.birthday = nil
    expect(user).to_not be_valid
    expect(user.errors[:birthday]).to include("を入力してください")
  end

  it "メールアドレスがなければ無効な状態であること" do
    user.email = nil
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "パスワードがなければ無効な状態であること" do
    user = build(:user, password: nil, password_confirmation: nil)
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("を入力してください")
  end

  it '名前が50文字以内であること' do
    user.name = 'a' * 51
    expect(user).to_not be_valid
    expect(user.errors[:name]).to include('は50文字以内で入力してください')
  end

  it 'メールアドレスが255文字以内であること' do
    user.email = 'a' * 244 + '@example.com'
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include('は255文字以内で入力してください')
  end

  it '自己紹介が50文字以内であること' do
    user.introduction = 'a' * 51
    expect(user).to_not be_valid
    expect(user.errors[:introduction]).to include('は50文字以内で入力してください')
  end

  it 'メールアドレスが重複しないこと' do
    user2 = build(:user, email: user.email)
    expect(user2).to_not be_valid
    expect(user2.errors[:email]).to include('はすでに存在します')
  end

  it 'パスワードの入力に制限があること' do
    user.password = 'password'
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include('は半角英数を両方含む必要があります')
  end

  it 'メールアドレスは小文字で保存されること' do
    user.email = 'EXAMPLE@EXAMPLE.COM'
    user.save!
    expect(user.reload.email).to eq('example@example.com')
  end

  it '5MBを超える画像は無効であること' do
    user.avatar.attach(large_image)
    expect(user).to_not be_valid
    expect(user.errors[:avatar]).to include('のサイズは5MB以下にしてください')
  end

  it '許可されていないファイル形式は無効であること' do
    user.avatar.attach(invalid_format_image)
    expect(user).to_not be_valid
    expect(user.errors[:avatar]).to include('はPNG、JPG、JPEG形式でアップロードしてください')
  end

  it '複数のDogと関連があること' do
    dog1 = create(:dog, user: user)
    dog2 = create(:dog, user: user)
    expect(user.dogs).to include(dog1, dog2)
  end

  it '複数のUserWeightと関連があること' do
    user_weight1 = create(:user_weight, user: user)
    user_weight2 = create(:user_weight, user: user)
    expect(user.user_weights).to include(user_weight1, user_weight2)
  end
end
