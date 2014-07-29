class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy

	#before_save { |user| user.email = user.email.downcase }
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	validates :name, presence: true, length: {maximum:55}, uniqueness: {case_sensitive: false}

	VALID_EMAIL_REGEX = /\A[\w\.\+-]+@[a-z\.\d-]+[a-z\d]\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}
	
	has_secure_password #method chiu trach nhiem ve tao cac thuoc tinh ao password va password_confirmation
	
	validates :password, presence: true, length: {minimum: 6}
	validates :password_confirmation, presence: true

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
	# This is preliminary. See "Following users" for the full implementation.
		Micropost.where("user_id = ?", id)
	end

	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
