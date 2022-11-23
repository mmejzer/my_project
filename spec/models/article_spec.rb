# frozen_string_literal: true

require 'rails_helper'

describe Article do
  let(:user) { build(:user) }

  context 'when public article' do
    let(:article) { build(:article, status: 'public', user: user) }

    it 'is valid' do
      expect(article).to be_valid
    end
  end

  context 'when draft' do
    let(:article) { build(:article, status: 'draft', user: user) }

    it 'is valid' do
      expect(article).to be_valid
    end
  end

  context 'with blank title' do
    let(:article) { build(:article, title: '', status: 'public', user: user) }

    it 'is not valid' do
      expect(article).not_to be_valid
    end
  end

  context 'with blank body' do
    let(:article) { build(:article, body: '', status: 'public', user: user) }

    it 'is not valid' do
      expect(article).not_to be_valid
    end
  end
end
