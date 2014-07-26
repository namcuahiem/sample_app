require 'spec_helper'
#test hoat dong cua static pages
describe "Static pages" do
	subject { page }

	describe "home page" do
		before { visit root_path }
		it { should have_title('Rails App') }
		it { should have_selector("h1", text: "Welcome") }
	end

	describe "help page" do
		before { visit help_path }
		it { should have_title(full_title('help')) }
		it { should have_selector("h1", text: "help") }
	end

	describe "about page" do
		before { visit about_path }
		it { should have_title(full_title('about')) }
		it { should have_selector("h1", text: "about") }
	end

	describe "contact page" do
		before { visit contact_path }
		it { should have_title(full_title('contact')) }
		it { should have_selector("h1", text: "contact") }
	end

	it "should have the right links" do
		visit root_path
		click_link "About"
		page.should have_title(full_title('about')) 

		click_link "Help"
		page.should have_title(full_title('help')) 

		click_link "Home"
		click_link "Sign up now"
		page.should have_title(full_title('signup')) 

		click_link "Contact"
		page.should have_title(full_title('contact')) 
	end

end

