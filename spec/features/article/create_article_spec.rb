# frozen_string_literal: true

require 'rails_helper'

describe 'Article' do
  shared_context 'with authorized user' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end
  end

  shared_context 'with no authorized user' do
  	let(:user) { create(:user) }
  	before do
      sign_out user
    end
  end

  feature 'Create article' do
    include_context 'with authorized user'

    before do
      visit new_article_path
  	end

    scenario 'with valid attributes' do
      fill_in 'Title', with: 'Title'
      fill_in 'Body', with: 'article'
      click_button 'Create Article'

      expect(page).to have_current_path "/articles/#{Article.last.id}"
      expect(page).to have_content 'Title'
      expect(page).to have_content 'article'
    end
  end

  feature 'Create article' do
    include_context 'with no authorized user'

    scenario 'with no authorized' do
      visit new_article_path
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
