class User < ApplicationRecord
    #attr_accessor :login_time
    #has_many :posts, dependant: :destroy
    attr_accessor :remember_token
    has_many :posts
    has_one_attached :avatar
    has_one_attached :verification

    validates :user_name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i 
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    validates :phone_number, presence: true, length: {minimum: 10, maximum: 13 }, format: { with: /\A\d+\z/}
    has_secure_password
    validates :password, presence: true, length: { minimum: 8, maximum: 20 }, allow_nil: true
    
    def login
        update_attribute(:login_time, Time.zone.now)
    end

    def name
        user_name
    end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost) 
    end

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def authenticated?(remember_token)
        if remember_digest.nil?
            false
        else
            BCrypt::Password.new(remember_digest).is_password?(remember_token)
        end
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:remember_digest,nil)
    end
end
