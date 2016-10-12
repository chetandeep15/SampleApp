require 'rails_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path}

    it "should have the content 'Sample App'" do
      expect(subject).to have_selector('h1', text: "Sample App")
    end

    it "should have the title 'Home'" do
      expect(subject).to have_title("Sample App | Home")
    end
  end

  describe "Help page" do
    before { visit help_path }
    it "should have the content 'Help'" do
      expect(subject).to have_selector('h1', text: "Help")
    end

    it "should have the title 'Help'" do
      expect(subject).to have_title("Sample App | Help")
    end
  end

  describe "About page" do
    before { visit about_path }
    it "should have the content 'About Us'" do
      expect(subject).to have_selector('h1', text: "About Us")
    end

    it "should have the title 'About Us'" do
      expect(subject).to have_title ("Sample App | About Us")
    end
  end

  describe "Contact page" do
    before { visit contact_path }
    it "should have the content 'Contact Us'" do
      expect(subject).to have_content('Contact Us')
    end

    it "should have title 'Contact Us'" do
      expect(subject).to have_title("Sample App | Contact Us")
    end

  end
end
