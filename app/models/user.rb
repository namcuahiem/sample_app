class User < ActiveRecord::Base
	#before_save { |user| user.email = user.email.downcase }
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: {maximum:15}, uniqueness: {case_sensitive: false}

	VALID_EMAIL_REGEX = /\A[\w\.\+-]+@[a-z\.\d-]+[a-z\d]\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
	
	has_secure_password #method chiu trach nhiem ve tao cac thuoc tinh ao password va password_confirmation
	
	validates :password, presence: true, length: {minimum: 6}
	validates :password_confirmation, presence: true

end
