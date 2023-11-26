require 'rails_helper'

RSpec.describe Diary, type: :model do
  let(:user) { create(:user) }
  let(:dog) { create(:dog, user: user) }
  let(:diary) { create(:diary, user: user, dog: dog) }
  let(:dummy_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/sample_user.jpg'), 'image/jpeg') }
  let(:large_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/large_avatar.jpg'), 'image/jpeg') }
  let(:invalid_format_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/invalid_avatar.svg'), 'image/svg') }

  it 'ユーザーとの関連付けが存在すること' do
    expect(diary.user_id).to eq(user.id)
  end

  it '犬との関連付けが存在すること' do
    expect(diary.dog_id).to eq(dog.id)
  end

  it '日記テキストが1000文字以内であること' do
    diary.diary_text = 'a' * 1001
    expect(diary).to_not be_valid
    expect(diary.errors[:diary_text]).to include("は1000文字以内で入力してください")
  end

  it '食事テキストが1000文字以内であること' do
    diary.meal_text = 'a' * 1001
    expect(diary).to_not be_valid
    expect(diary.errors[:meal_text]).to include("は1000文字以内で入力してください")
  end

  it '運動テキストが1000文字以内であること' do
    diary.exercise_text = 'a' * 1001
    expect(diary).to_not be_valid
    expect(diary.errors[:exercise_text]).to include("は1000文字以内で入力してください")
  end

  it '健康テキストが1000文字以内であること' do
    diary.health_text = 'a' * 1001
    expect(diary).to_not be_valid
    expect(diary.errors[:health_text]).to include("は1000文字以内で入力してください")
  end

  it '写真が4枚までであること' do
    5.times { diary.photos.attach(dummy_image) }
    expect(diary).to_not be_valid
    expect(diary.errors[:photos]).to include('は最大4枚までです。')
  end

  it '許可されていないファイル形式は無効であること' do
    diary.photos.attach(invalid_format_image)
    expect(diary).to_not be_valid
    expect(diary.errors[:photos]).to include('はPNG、JPG、JPEG形式でアップロードしてください')
  end

  it '5MBを超える画像は無効であること' do
    diary.photos.attach(large_image)
    expect(diary).to_not be_valid
    expect(diary.errors[:photos]).to include('のサイズは5MB以下にしてください')
  end
end
