class User < ApplicationRecord
  before_save :downcase_email
  has_many :dogs, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze

  validates :name, presence: true, length: {maximum: 50}
  validates :birthday, presence: true
  validates :email, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }
  validates :introduction, length: {maximum: 50}

  private

  def downcase_email
    self.email = email.downcase
  end
end
