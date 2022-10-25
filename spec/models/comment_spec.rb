# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  let(:user) { build(:user) }
  let(:article) { build(:article, status: 'public', user: user) }
  let(:comment) { build(:comment, article: article, user: user) }

  it 'with valid attributes' do
    expect(comment).to be_valid
  end
end
