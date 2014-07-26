require 'spec_helper'
#test hoat dong cua user pages
describe "UserPages" do
	subject { page }
	describe "signup page" do
		before { visit signup_path }
		it { should have_title(full_title('signup ')) }
		it { should have_selector("h1", text: "signup") }
	end
end
