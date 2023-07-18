class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        validates :nickname, presence: true
        validate :validate_email_format

        with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: '全角文字を使用してください' } do
          validates :last_name, presence: true
          validates :first_name, presence: true
          validates :last_name_kana, presence: true
          validates :first_name_kana, presence: true
        end

        validates :date_of_birth, presence: true

  def validate_email_format
    unless email =~ /\A[^@\s]+@[^@\s]+\z/
      errors.add(:email, 'は有効なメールアドレスではありません')
    end
  end
end
