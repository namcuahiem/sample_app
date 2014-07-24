require 'spec_helper'
let(:base_title) { "Rails App" } #khai bao bien
describe "StaticPages" do
	describe "home page" do
		it "need to have title home" do
			visit '/static_pages/home'
			expect(page).to have_title('#{base_title} | home')
		end

		it "need to have title home" do
			visit '/static_pages/home'
			expect(page).to have_title('Rails App | home')
		end
	end

	describe "help page" do
		it "need to have title help" do
			visit '/static_pages/help'
			expect(page).to have_title('Rails App | help')
		end
	end

	describe "about page" do
		it "need to have title about" do
			visit '/static_pages/about'
			expect(page).to have_title('Rails App | about')
		end
	end

	describe "contact page" do
		it "need to have title about" do
			visit '/static_pages/contact'
			expect(page).to have_title('Rails App | contact')
		end
	end
end
