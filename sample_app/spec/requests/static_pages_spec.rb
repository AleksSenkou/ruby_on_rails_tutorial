require 'rails_helper'

describe "StaticPages" do
  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_selector 'h1', text: page_name }
    it { should have_title page_name }
  end

  describe "Home page" do
    before { visit root_path }
    let(:page_name) { 'Sample App' }

    it_should_behave_like 'all static pages'
    it { should_not have_title('| Home') }
  end

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

  it 'should have the right links on the layout' do
    visit root_path
    click_link 'About'
    expect(page).to have_title 'About Us'
  end
end