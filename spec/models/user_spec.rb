require 'spec_helper'

describe User do
	before { @user = User.new(name: "Test", email:"test@gmail.com", password:"hello123", password_confirmation:"hello123")}
	subject {@user}
	it { should respond_to(:name)} #user co lien quan den :name
	it { should respond_to(:email)}
	it { should respond_to(:password_digest)}
	it { should respond_to(:password)} #attribute ảo của class User, tạo ra bới has_secure_password method
	it { should respond_to(:password_confirmation)} #attribute ảo của class User, tạo ra bới has_secure_password method

	describe "when name is not present" do
		before { @user.name = " "}
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " "}
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = 'a'*51}
		it { should_not be_valid }
	end
	#test nhung email khong hop le
	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo
				foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end
	#test nhung email hop le
	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe "when email is duplicate" do
		before do
			duplicate_user = @user.dup
			duplicate_user.email = @user.email
			duplicate_user.save
		end
		it { should_not be_valid }
	end

	describe "when email is duplicate in UPPERCASE" do
		before do
			duplicate_user = @user.dup
			duplicate_user.email = @user.email.upcase
			duplicate_user.save
		end
		it { should_not be_valid }
	end

	describe "when name is duplicate" do
		before do
			duplicate_user = @user.dup
			duplicate_user.name = @user.name
			duplicate_user.save
		end
		it { should_not be_valid }
	end

	describe "when password is too short" do
		before { @user.password=@user.password_confirmation='a'*5 }
		it { should_not be_valid }
	end

	describe "when password doesn't match to confirmation" do
		before { @user.password_confirmation="otherpassword" }
		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password=@user.password_confirmation='' }
		it { should_not be_valid }
	end

	describe "when password confirmation is nil" do
		before { @user.password_confirmation=nil }
		it { should_not be_valid }
	end

	describe "authentication analysis" do
		before { @user.save }
		let(:current_user){ User.find_by(email:@user.email) }
		
		describe "correct password" do
			it { should == current_user.authenticate(@user.password) }
		end

		describe "wrong password" do
			it { should_not == current_user.authenticate("otherpassword") }
		end
	end
end
