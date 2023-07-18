class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        validates :nickname, presence: true
        validate :validate_email_format

        with_options presence: true do
          validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'は全角文字を使用してください' }
          validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'は全角文字を使用してください' }
          validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
          validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください' }
          validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'は英字と数字の両方を含めて設定してください' }
        end

        validates :date_of_birth, presence: true

  def validate_email_format
    unless email =~ /\A[^@\s]+@[^@\s]+\z/
      errors.add(:email, 'は有効なメールアドレスではありません')
    end
  end
end
