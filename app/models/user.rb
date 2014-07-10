class User < ActiveRecord::Base
	#attr_accessible :name, :email, :password, :password_confirmation
	#a callback executes a particular of code at a particular time in the life-cycle
	#of an active record object
	#before_save { |user| user.email = user.email.downcase }
	before_save { self.email = email.downcase }
	validates :name, presence: true,
			  length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true,
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	validates :password, presence: true,
						 length: { minimum: 6 }
	validates :password_confirmation, presence: true

	has_secure_password
end
