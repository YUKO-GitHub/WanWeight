require 'rails_helper'

RSpec.describe Dog, type: :model do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }
  let(:large_image) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'large_avatar.jpg'), 'image/jpeg') }
  let(:invalid_format_image) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'invalid_avatar.svg'), 'image/svg') }

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

  it 'ユーザーと関連があること' do
    expect(dog.user_id).to eq(user.id)
  end
end
