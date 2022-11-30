# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  let(:user) { build(:user) }
  let(:article) { build(:article, user: user) }

  context 'when public comment' do
    let(:comment) { build(:comment, user: user, article: article) }

    it 'is valid' do
      expect(comment).to be_valid
    end
  end

  context 'with blank body' do
    let(:comment) { build(:comment, body: '', user: user, article: article) }

    it 'is not valid' do
      expect(comment).not_to be_valid
    end
  end
end
