require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Sign up') }
		it { should have_title(full_title('Sign up')) }
	end

	describe "profile page" do
		             #the :user used in this is from factories.rb
		let(:user) { FactoryGirl.create(:user) }
		before { visit user_path(user) }

		it { should have_selector('h1',    text: user.name) }
		it { should have_title(full_title(user.name)) }
	end

	describe "signup" do
		before { visit signup_path }
		let(:submit) { "Create my account" } 

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit}.not_to change(User, :count)
			end

			describe "after submission with all fields blank" do
				error_messages = ["Name can't be blank",
													"Email can't be blank",
													"Email is invalid",
													"Password can't be blank",
													"Password is too short"]
				before { click_button submit }
				it { should have_title('Sign up') }
				it { should have_content('error') }

				error_messages.each do |error_message|
					it { should have_content(error_message) }
				end
			end

			describe "after submission with empty password_confirmation" do
				before do
					fill_in "Name",					with: "Example User"
					fill_in "Email", 				with: "user@example.com"
					fill_in "Password", 		with: "foobar"

					click_button submit
				end

				it { should have_content("Password confirmation doesn't match Password") }
				it { should have_content("Password confirmation can't be blank") }
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",					with: "Example User"
				fill_in "Email", 				with: "user@example.com"
				fill_in "Password", 		with: "foobar"
				fill_in "Confirmation", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving a user" do
				before { click_button submit }
				let(:user) { User.find_by_email('user@example.com') }

				it { should have_title(user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
			end
		end
	end 
end