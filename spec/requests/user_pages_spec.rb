require 'spec_helper'
#test hoat dong cua user pages
describe "UserPages" do
	subject { page }
	
	describe "signup page" do
		before { visit signup_path }
		it { should have_title(full_title('signup ')) }
		it { should have_selector("h1", text: "Sign up") }
	end

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }
		it { should have_content(user.name) }
		it { should have_content(user.email) }
		it { should have_title(full_title(user.name)) }
	end

	describe "signup action" do
		before { visit signup_path }
		describe "with invalid information" do
			it "should not create a user" do
				expect {click_button "Create my account" }.not_to change(User, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name", with: "Tai Nguyen"
				fill_in "Email", with: "namcuahiem@gmail.com"
				fill_in "Password", with: "hello123"
				fill_in "Password confirmation", with: "hello123"
			end

			it "should create a user" do
				expect { click_button "Create my account"}.to change(User, :count).by(1)
			end
		end
	end
end
