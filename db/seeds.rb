def generate_guest_password
  base_password = SecureRandom.alphanumeric(8)
  base_password + "A1"
end

User.find_or_create_by!(email: 'guest@example.com') do |user|
  user.password = generate_guest_password
  user.name = "ゲストユーザー"
  user.birthday = Date.new(2000, 1, 1)
  user.height = 170.0
  user.introduction = "これはゲストユーザーの紹介文です。"
end

