User.find_or_create_by!(email: 'guest@example.com') do |user|
  user.password = SecureRandom.urlsafe_base64
  user.name = "ゲストユーザー"
  user.birthday = Date.new(2000, 1, 1)
  user.height = 170.0
  user.introduction = "これはゲストユーザーの紹介文です。"
end
