require 'rails_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_selector('h1', text: "Sample App")
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Sample App | Home")
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_selector('h1', text: "Help")
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Sample App | Help")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_selector('h1', text: "About Us")
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title ("Sample App | About Us")
    end
  end

  describe "Contact page" do
    it "should have the content 'Contact Us'" do
      visit 'static_pages/contact'
      expect(page).to have_content('Contact Us')
    end

    it "should have title 'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_title("Sample App | Contact Us")
    end

  end
end
