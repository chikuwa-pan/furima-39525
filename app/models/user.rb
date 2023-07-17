class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        validates :nickname, presence: true
        validate :validate_email_format
        validates :last_name, presence: true
        validates :first_name, presence: true
        validates :last_name_kana, presence: true
        validates :first_name_kana, presence: true
        validates :date_of_birth, presence: true

  def validate_email_format
    unless email =~ /\A[^@\s]+@[^@\s]+\z/
      errors.add(:email, 'は有効なメールアドレスではありません')
    end
  end
end
