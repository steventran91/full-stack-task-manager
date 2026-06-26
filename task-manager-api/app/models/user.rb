class User < ApplicationRecord
    has_secure_password
    has_many :tasks

    validates :first_name, :last_name, :email, presence: true
    validates :email, uniqueness: true, format: {with: URI::MailTo::EMAIL_REGEXP}
end
