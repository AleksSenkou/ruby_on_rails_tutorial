require 'rails_helper'

describe "StaticPages" do
  let(:content_it) {"should have content"}
  let(:title_it) {"should have title"}

  describe "Home page" do
    it "#{:content_it} 'Sample App'" do
      visit root_path 
      expect(page).to have_content 'Sample App'
    end

    it "#{:title_it} 'Sample App'" do
      visit root_path
      expect(page).to have_title 'Sample App'
    end

    it "should not have a custom page title" do
      visit root_path
      expect(page).not_to have_title ' | Home'
    end
  end

  describe "Help page" do
    it "#{:content_it} 'Help'" do
      visit help_path
      expect(page).to have_content 'Help'
    end

    it "#{:title_it} 'Help'" do
      visit help_path
      expect(page).to have_title 'Help'
    end
  end

  describe "About page" do
    it "#{:content_it} 'About Us'" do
      visit about_path
      expect(page).to have_content 'About Us'
    end

    it "#{:title_it} 'About'" do
      visit about_path
      expect(page).to have_title 'About'
    end
  end

  describe "Contact" do
    it "#{:content_it} 'Contact'" do
      visit contact_path
      expect(page).to have_content 'Contact'
    end

    it "#{:title_it} 'Contact'" do
      visit contact_path
      expect(page).to have_title 'Contact'
    end
  end
end
