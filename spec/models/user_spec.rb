require 'rails_helper'

describe 'User' do
  before { @user = User.new(name: "Test User", email: "Test@rspec.com", password: 'foobar', password_confirmation: 'foobar')  }

  it ' should respond to name' do
    expect(@user).to respond_to(:name)
  end

  it 'should respond to email' do
    expect(@user).to respond_to(:email)
  end

  it 'should respond to password' do
    expect(@user).to respond_to(:password)
  end

  it 'should respond to password_confirmation' do
    expect(@user).to respond_to(:password_confirmation)
  end

  it 'should be valid' do
    expect(@user).to be_valid
  end
end

describe 'name or email not present' do
  before{ @user = User.new(name: "", email: "Test@rspec.com")}

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
  @user = User.new(name: "Test User", email: "Test@rspec.com")
  before { @user.password = @user.password_confirmation = " " }
  it 'should not be valid' do
     expect(@user).to_not be_valid
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
  before { @user = User.new }
  it "should be valid" do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      @user.name = 'Test User'
      @user.email = valid_address
      expect(@user).to be_valid
      end
    end
  end


