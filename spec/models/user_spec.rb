# frozen_string_literal: true

require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end
end
