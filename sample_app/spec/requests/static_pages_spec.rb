require 'rails_helper'

describe "StaticPages" do
  let(:content_it) {"should have content"}
  let(:title_it) {"should have title"}


  describe "Home page" do
    it "#{:content_it} 'Sample App'" do
      visit 'static_pages/home'
      expect(page).to have_content 'Sample App'
    end

    it "#{:title_it} 'Home'" do
      visit 'static_pages/home'
      expect(page).to have_title 'Home'
    end
  end

  describe "Help page" do
    it "#{:content_it} 'Help'" do
      visit 'static_pages/help'
      expect(page).to have_content 'Help'
    end

    it "#{:title_it} 'Help'" do
      visit 'static_pages/help'
      expect(page).to have_title 'Help'
    end
  end

  describe "About page" do
    it "#{:content_it} 'About Us'" do
      visit 'static_pages/about'
      expect(page).to have_content 'About Us'
    end

    it "#{:title_it} 'About'" do
      visit 'static_pages/about'
      expect(page).to have_title 'About'
    end
  end

  describe "Contact" do
    it "#{:content_it} 'Contact'" do
      visit 'static_pages/contact'
      expect(page).to have_content 'Contact'
    end

    it "#{:title_it} 'Contact'" do
      visit 'static_pages/contact'
      expect(page).to have_title 'Contact'
    end
  end
end
