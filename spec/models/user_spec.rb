require 'rails_helper'

describe User, type: :model do
  before(:all) do
    @user1 = build(:user)
  end
  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  context "no first_name" do
    it " not valid " do
      user2 = build(:user, first_name: nil)
      expect(user2).to_not be_valid
    end
  end

  context "no last_name" do
    it "is not valid without a last_name" do
      user2 = build(:user, last_name: nil)
      expect(user2).to_not be_valid
    end
  end

  context "no email" do
    it "is not valid without a email" do   
      user2 = build(:user, email: nil)
      expect(user2).to_not be_valid
    end
  end

  context "no password" do
    it "is not valid without a password" do    
      user2 = build(:user, password: nil)
      expect(user2).to_not be_valid
    end
  end
end