require 'rails_helper'

describe 'User' do
  let(:user) {FactoryGirl.create(:user)}

  it ' should respond to name' do
    expect(user).to respond_to(:name)
  end

  it 'should respond to email' do
    expect(user).to respond_to(:email)
  end

  it 'should respond to password' do
    expect(user).to respond_to(:password)
  end

  it 'should respond to password_confirmation' do
    expect(user).to respond_to(:password_confirmation)
  end

  it 'should respond to remember token' do
    expect(user).to respond_to(:remember_token)
  end

  it 'should respond to admin' do
    expect(user).to respond_to(:admin)
  end

  it 'should respond to feed' do
    expect(user).to respond_to(:feed)
  end

  it 'should respond to relationships' do
    expect(user).to respond_to(:relationships)
  end

  it 'should respond to followed user' do
    expect(user).to respond_to(:followed_users)
  end

  it 'should respond to reversed relationships' do
    expect(user).to respond_to(:reverse_relationships)
  end

  it 'should respond to followers' do
    expect(user).to respond_to(:followers)
  end

  it 'should respond to following' do
    expect(user).to respond_to(:following?)
  end

  it 'should respond to follow' do
    expect(user).to respond_to(:follow!)
  end

  it 'should respond to unfollow!' do
    expect(user).to respond_to(:unfollow!)
  end

  it 'should be valid' do
    expect(user).to be_valid
  end

  it 'should not be an admin' do
    expect(user).to_not be_admin
  end


describe 'name or email not present' do
  before{ user = User.new(name: "", email: "Test@rspec.com")}

  it 'should not be valid when name is empty' do
    user = User.new(name: "", email: "Test@rspec.com")
    expect(user).to_not be_valid
  end

  it 'should not be valid when email is empty' do
    user = User.new(name: "Test User", email: "")
    expect(user).to_not be_valid
  end
end

describe "when password is not present" do
  let(:user) { User.new(name: "Test User", email: "Test@rspec.com") }
  before { user.password = user.password_confirmation = " " }
  it 'should not be valid' do
     expect(user).to_not be_valid
  end
end

describe 'name too long' do
  before {@user = User.new(name: 'a'*31, email: 'test@example.com')}

  it 'should not be valid' do
    expect(@user).to_not be_valid
  end
end

describe "when email format is invalid" do
  before { @user = User.new }
  it "should be invalid" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      @user.name = 'Test User'
      @user.email = invalid_address
      expect(@user).to_not be_valid
    end
  end
end

describe "when email format is valid" do
  before { @user = FactoryGirl.create(:user) }
  it "should be valid" do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      @user.name = 'Test User'
      @user.email = valid_address
      expect(@user).to be_valid
    end
  end
end

  describe 'user changed to admin' do
    before { user.toggle!(:admin)}
    it 'should be admin' do
      expect(user).to be_admin
    end
  end

  describe ' when password is not present' do
    before { user.password = user.password_confirmation = " " }
    it { expect(user).to_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { expect(user).to_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { user.password_confirmation = nil }
    it { expect(user).to_not be_valid }
  end

  describe "when password is too short" do
    before { user.password = user.password_confirmation = "a" * 5 }
    it { expect(user).to_not be_valid }
  end

  describe "return value of authenticate method" do
    before { user.save }
    let(:found_user) { User.find_by_email(user.email) }

    describe "with valid password" do
      it { expect(user).to eq (found_user.authenticate(user.password)) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { expect(user).to_not eq(user_for_invalid_password) }
      specify { expect(user_for_invalid_password).to be_falsey }
    end
  end

  describe "remember token" do
    before { user.save }
    it { expect(user.remember_token).to_not be_blank }
  end

  describe "micropost associations" do

    before { user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(user.microposts).to eq([newer_micropost, older_micropost])
    end

    it "should destroy associated microposts" do
      microposts = user.microposts
      user.destroy
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

  end

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      user.save
      user.follow!(other_user)
    end

    it { expect(user).to be_following(other_user) }
    it { expect(user.followed_users).to include(other_user) }

    describe "followed user" do
      subject { other_user }
      it { expect(other_user.followers).to include(user) }
    end

    describe "and unfollowing" do
      before { user.unfollow!(other_user) }

      it { expect(user).to_not be_following(other_user) }
      it { expect(user.followed_users).to_not include(other_user) }
    end
  end
end
