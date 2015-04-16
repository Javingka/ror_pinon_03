class User < ActiveRecord::Base
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

end
