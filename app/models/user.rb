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
  validates :height, presence: true
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

  def bmi
    latest_weight_record = user_weights.order(:date).last
    return nil if height.blank? || latest_weight_record.blank? # rubocop:disable Airbnb/SimpleModifierConditional
    (latest_weight_record.weight / ((height / 100)**2)).round(1)
  end

  def bmi_status
    case bmi
    when ..18.5
      '低体重(痩せ型)'
    when 18.5...25
      '普通体重'
    when 25...30
      '肥満(1度)'
    when 30...35
      '肥満(2度)'
    when 35...40
      '肥満(3度)'
    else
      '肥満(4度)'
    end
  end

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
