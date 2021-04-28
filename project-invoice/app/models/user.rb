class User < ApplicationRecord
  has_secure_password

  before_save   :downcase_email

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z]+[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name,  presence: true
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  # Permitimos nill porque has_secure_password verifica
  # la presencia de password y password_confirmation
  validates :password,  presence: true, length: { minimum: 8 }, allow_nil: true

  private

    # Se encarga de que email tenga sólo letras minúsculas
    def downcase_email
      self.email.downcase!
    end
end
