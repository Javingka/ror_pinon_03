class User < ActiveRecord::Base
  attr_accessor :remember_token
  
	before_save { self.email = email.downcase }	

	validates :name, presence: true, length: { maximum: 50 }
 # to understand this regular expression http://www.rubular.com/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX },
					uniqueness: { case_sensitive: false }

  has_secure_password
	validates :password, length: { minimum: 6 }

  # Adding a digest method for use in fixtures
  # Returns the hash digest of the given string | usado para testar usuarios, login logout
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token The urlsafe_base64 method from the SecureRandom module in the Ruby standard library
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forget a user
  def forget
    update_attribute(:remember_digest, nil)
  end

end
