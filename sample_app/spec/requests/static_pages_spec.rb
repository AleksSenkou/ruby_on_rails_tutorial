require 'rails_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_selector 'h1', text: page_name }
    it { should have_title page_name }
  end

  # describe "Home page" do
  #   before { visit root_path }
  #   let(:page_name) { 'Sample App' }

  #   it { should have_link 'Sign in' }
  #   it_should_behave_like 'all static pages'
  #   it { should_not have_title('| Home') }
  # end

  describe "Help page" do
    before { visit help_path }
    let(:page_name) { 'Help' }

    it_should_behave_like 'all static pages'
  end

  describe "About page" do
    before { visit about_path }
    let(:page_name) { 'About Us' }

    it_should_behave_like 'all static pages'
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:page_name) { 'Contact' }

    it_should_behave_like 'all static pages'
  end

  # it 'should have the right links on the layout' do
  #   visit root_path
  #   click_link 'About'
  #   expect(page).to have_title 'About Us'
  #   click_link 'Help'
  #   expect(page).to have_title 'Help'
  #   click_link 'Contact'
  #   expect(page).to have_title 'Contact'
  #   click_link 'sample app'
  #   expect(page).to have_title 'Sample App'
  #   click_link 'Sign up now!'
  #   expect(page).to have_title 'Sign Up'
  # end

  describe 'for sign-in user' do
    let(:user) { FactoryGirl.create :user }
    before {
      FactoryGirl.create(:micropost, user: user, content: 'Lorem ipsum')
      FactoryGirl.create(:micropost, user: user, content: 'Lorem')
      sign_in user
      visit root_path
    }

    it "should render the user's feed" do
      user.feed.each do |item|
        expect(page).to have_selector("li##{item.id}", text: item.content)
      end
    end

    describe 'following/followers counts' do
      let(:other_user) { FactoryGirl.create :user }
      before {
        other_user.follow! user
        visit root_path
      }

      it { should have_link('0 following', href: following_user_path(user)) }
      it { should have_link('1 followers', href: followers_user_path(user)) }
    end
  end
end