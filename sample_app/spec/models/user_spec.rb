require 'rails_helper'

describe User, type: :model do
  before { @user = User.new(name: 'Alex', email: 'wrong@man.net', 
                            password: 'foobar', password_confirmation: 'foobar') }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should be_valid }


  describe 'when name is not present' do
    before { @user.name = '  ' }
    it { should_not be_valid }
  end

  describe 'when name is too long' do
    before { @user.name = 'a' * 31 }
    it { should_not be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = '  ' }
    it { should_not be_valid }
  end

  describe 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org user_at_foo@e2dc..org 
                     example.user@foo. foo@baz_bar.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe 'when email format is valid' do
    it 'should be valid' do
      addresses = %w[user@foo.COM user_at_foo@edc.org 
                     example.user@foo.com.org foo@bazbar.com foo+baz@barbaz.com]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe 'when email address is already taken' do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase!
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe 'when email save in dowcase' do
    let(:upcase_email) { "ALEX@GMAIL.COM" }

    it 'should be saved as all lower-case' do
      @user.email = upcase_email
      @user.save
      expect(@user.email).to eq upcase_email.downcase
    end
  end

  describe 'when password is not present' do
    before { @user = User.new(name: 'Alex', email: 'wrong@man.net', 
                              password: ' ', password_confirmation: ' ') }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email @user.email }

    describe "with valid password" do
      it { should eq found_user.authenticate @user.password }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate "invalid" }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end
end