class User < ApplicationRecord
  before_save :downcase_email
  has_many :dogs, dependent: :destroy
  has_many :user_weights, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_one_attached :avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i

  validates :name, presence: true, length: { maximum: 20 }
  validates :birthday, presence: true
  validates :email, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }, if: :password_present?
  validates :introduction, length: { maximum: 100 }
  validates :avatar, content_type: {
                       in: ['image/png', 'image/jpg', 'image/jpeg'],
                       message: 'はPNG、JPG、JPEG形式でアップロードしてください',
                     },
                     size: {
                       less_than: 5.megabytes,
                       message: 'のサイズは5MB以下にしてください',
                     }
  validate :prevent_guest_user_updates, on: :update

  private

  def downcase_email
    self.email = email.downcase
  end

  def password_present?
    password.present?
  end

  def prevent_guest_user_updates
    if email == 'guest@example.com' && (email_changed? || encrypted_password_changed?)
      errors.add(:base, 'ゲストユーザーのメールアドレスとパスワードは変更できません。')
    end
  end
end
