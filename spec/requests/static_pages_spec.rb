require 'spec_helper'

describe "StaticPages" do

  subject { page }
  
  describe "Home page" do
  	before { visit '/static_pages/home' }

		it { should have_content('Sample App') }
		it { should have_title(full_title('')) }
  end

  describe "Help page" do
  	before { visit '/static_pages/help' }

  	it { should have_content('Help') }
  	it { should have_title(full_title('Help')) }
  end

  describe "About page" do
  	before { visit '/static_pages/about' }

  	it { should have_content('About Us') }
  	it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
  	before { visit '/static_pages/contact' }

  	it { should have_content('Contact') }
  	it { should have_title(full_title('Contact')) }
  end

end