# frozen_string_literal: true

require 'rails_helper'

describe 'Create article' do
  let(:user) { create(:user) }

  scenario 'when authorized user with valid attributes' do
    sign_in user
    visit new_article_path

    fill_in 'Title', with: 'Title'
    fill_in 'Body', with: 'article'
    click_button 'Create Article'

    expect(page).to have_current_path "/articles/#{Article.last.id}"
    expect(page).to have_content 'Your article was created'
    expect(page).to have_content 'Title'
    expect(page).to have_content 'article'
    expect(page).to have_content "Author: #{Article.last.user.first_name} #{Article.last.user.last_name}"
    expect(page).to have_content "Posted on #{Article.last.created_at.strftime('%H:%M %d %B %Y')}"
  end

  scenario 'when authorized user with invalid attributes', js: true do
    sign_in user
    visit new_article_path

    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_button 'Create Article'

    expect(page).not_to have_content 'Your article was created'
    expect(page).to have_current_path '/articles/new'
  end

  scenario 'when user is not authorized' do
    visit new_article_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
