FactoryGirl.define do
	factory :user do	#object of User class
		name	"Tai"
		email	"namcuahiem@gmail.com"
		password	"hello123"
		password_confirmation	"hello123"
	end
end