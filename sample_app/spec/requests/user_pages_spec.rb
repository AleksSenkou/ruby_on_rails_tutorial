require 'rails_helper'

describe "User Pages", type: :request do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "user_name",                  with: "Example User"
        fill_in "user_email",                 with: "user@example.com"
        fill_in "user_password",              with: "foobar"
        fill_in "user_password_confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(:email, 'aleksey.senkou@gmail.com') }

        it { should have_selector("div.alert.alert-success", text: 'Welcome') }
      end
    end
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create :user }
    before { visit user_path user }

    it { should_not have_title user.name}
    it { should have_content user.name }
  end
end