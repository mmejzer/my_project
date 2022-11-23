# frozen_string_literal: true

require 'rails_helper'

describe 'Edit Article' do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:article) { create(:article, user: user) }

  scenario 'when as author with valid attribute' do
    sign_in user
    visit edit_article_path(article)

    fill_in 'Title', with: 'Edit title'
    fill_in 'Body', with: 'Test edit article text'
    click_button 'Update Article'

    expect(page).to have_current_path "/articles/#{article.id}"
    expect(page).to have_content 'Your article was edited'
    expect(page).to have_content 'Edit title'
    expect(page).to have_content "Author: #{article.user.first_name} #{article.user.last_name}"
    expect(page).to have_content "Posted on #{article.created_at.strftime('%H:%M %d %B %Y')}"
    expect(page).to have_content "Update on #{article.updated_at.strftime('%H:%M %d %B %Y')}"
    expect(page).to have_content 'Test edit article text'
  end

  scenario 'when as author with invalid attribute', js: true do
    sign_in user
    visit edit_article_path(article)

    fill_in 'Title', with: ''
    fill_in 'Body', with: ''
    click_button 'Update Article'

    expect(page).to have_current_path(edit_article_path(article))
    expect(page).not_to have_content 'Your article was edited'
  end

  scenario 'when authorized user not is author' do
    sign_in user2
    visit edit_article_path(article)

    expect(page).to have_content 'You can not take this action.'
  end

  scenario 'when user is not authorized' do
    visit edit_article_path(article)
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
