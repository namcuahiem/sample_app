class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower

	validates :follower_id, presence: true
	validates :followed_id, presence: true

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
		#Micropost.where("user_id = ?", id)
		Micropost.from_users_followed_by(self)
	end

	def following?(someone)
		self.relationships.find_by(followed_id: someone.id)
	end

	def follow!(someone)
		self.relationships.create!(followed_id: someone.id)
	end

	def unfollow!(someone)
		self.relationships.find_by(followed_id: someone.id).destroy
	end

	private
		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
