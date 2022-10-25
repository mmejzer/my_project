# frozen_string_literal: true

require 'rails_helper'

describe Article, type: :model do
  let(:user) { build(:user) }

  context 'public article' do 
    let(:article) { build(:article, status: 'public', user: user) }
    it 'with valid attributes' do 
      expect(article).to be_valid
    end
  end

  context 'draft' do
    let(:article) { build(:article, status: 'draft', user: user) }
    it 'valid attributes draft' do     
      expect(article).to be_valid
    end
  end
end
