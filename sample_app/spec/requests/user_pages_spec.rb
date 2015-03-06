require 'rails_helper'

describe "User Pages", type: :request do
  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content "Sign Up" }
    it { should have_title "Sign Up" }
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create :user }
    before { visit user_path user }

    it { should_not have_title user.name}
    it { should have_content user.name }
  end
end