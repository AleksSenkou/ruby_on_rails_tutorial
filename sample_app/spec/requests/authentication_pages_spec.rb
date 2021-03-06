require 'rails_helper'

RSpec.describe "Authentication", type: :request do
  subject { page }

  describe "signin page" do
    before { visit signin_path }
    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end 

  describe "signin" do
    before { visit signin_path }

    describe "with invalid info" do
      before { click_button "Sign in" }

      it { should have_title "Sign in" }
      it { should have_selector 'div.alert.alert-danger' }

      # describe "after visiting another page" do
      #   before { click_link 'Home' }
      #   it { should_not have_selector 'div.alert.alert-danger' }
      # end
    end

    describe "with valid info" do
      let(:user) { FactoryGirl.create :user }
      before { sign_in user }

      it { should_not have_title user.name }
      it { should have_link "Profile",      href: user_path(user) }
      it { should have_link "Users",        href: users_path }
      it { should have_link "Settings",     href: edit_user_path(user) }
      it { should have_link "Sign out",     href: signout_path }
      it { should_not have_link "Sign in",  href: signin_path }

      # describe 'followed by signout' do
      #   before { click_link 'Sign out' }
      #   it { should have_link 'Sign in' }
      # end
    end
  end

  describe 'authorization' do

    describe 'for non-signed-in users' do
      let(:user) { FactoryGirl.create :user } 

      describe 'visiting the following page' do
        before { visit following_user_path user }
        it { should have_title 'Sign in' }
      end

      describe 'visiting the followers page' do
        before { visit followers_user_path user }
        it { should have_title 'Sign in' }
      end

      describe 'when attempting to visit a protected page' do
        before {
          visit edit_user_path user
          sign_in user
        }

        describe'after sign in' do
          it 'should render the desired protected page' do
            expect(page).to have_content 'Update'
          end
        end
      end

      describe 'in a User controller' do

        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }
          it { should have_title 'Sign in' }
        end

        describe 'submitting to the update action' do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe 'visiting the user index' do
          before {
            sign_in user 
            visit users_path 
          }
          it { should have_title 'All users' }
        end
      end

      describe 'in the Relationships conroller' do
        describe 'submitting to the create action' do
          before { post relationships_path }
          specify { expect(response).to redirect_to(signin_path) }
        end

        # describe 'submitting to the destroy action' do
        #   before { delete relationships_path(1) }
        #   specify { expect(response).to redirect_to(signin_path) }
        # end
      end

      describe 'in the Microposts controller' do

        describe 'submitting to the create action' do
          before { post microposts_path }
          specify { expect(response).to redirect_to signin_path }
        end

        describe 'submitting to the destroy action' do
          before { delete micropost_path(FactoryGirl.create :micropost) }
          specify { expect(response).to redirect_to signin_path }
        end
      end
    end

    describe 'as wrong user' do
      let(:user) { FactoryGirl.create :user }
      let(:wrong_user) { FactoryGirl.create :user, email: "wrong@example.com" }
    end

    describe 'as non-admin user' do
      let(:user) { FactoryGirl.create :user }
      let(:non_admin) { FactoryGirl.create :user }
    end
  end
end