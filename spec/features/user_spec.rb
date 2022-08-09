# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  let(:user) { build(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  context 'no first_name' do
    let(:user) { build(:user, first_name: nil) }

    it 'not valid' do
      expect(user).to_not be_valid
    end
  end

  context 'no last_name' do
    let(:user) { build(:user, last_name: nil) }

    it 'is not valid without a last_name' do
      expect(user).to_not be_valid
    end
  end

  context 'no email' do
    let(:user) { build(:user, email: nil) }

    it 'is not valid without a email' do
      expect(user).to_not be_valid
    end
  end

  context 'no password' do
    let(:user) { build(:user, password: nil) }

    it 'is not valid without a password' do
      expect(user).to_not be_valid
    end
  end
end
