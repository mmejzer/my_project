# frozen_string_literal: true

require 'rails_helper'

describe 'Show Article' do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:article) { create(:article, title: 'Title', body: 'article', user: user) }

  scenario 'when autorized user is author' do
    sign_in user
    visit article_path(article)

    expect(page).to have_content article.title
    expect(page).to have_link(href: "/articles/#{article.id}/edit")
    expect(page).to have_css('.button-delete')
    expect(page).to have_content "Author: #{article.user.first_name} #{article.user.last_name}"
    expect(page).to have_content "Posted on #{article.created_at.strftime('%H:%M %d %B %Y')}"
    expect(page).to have_content article.title
    expect(page).to have_content article.body
  end

  scenario 'when user is not authorized' do
    visit article_path(article)

    expect(page).to have_content article.title
    expect(page).not_to have_link(href: "/articles/#{article.id}/edit")
    expect(page).not_to have_css('.button-delete')
    expect(page).to have_content "Author: #{article.user.first_name} #{article.user.last_name}"
    expect(page).to have_content "Posted on #{article.created_at.strftime('%H:%M %d %B %Y')}"
    expect(page).to have_content article.body
  end

  scenario 'when autorized user is not author' do
    sign_in user2
    visit article_path(article)

    expect(page).to have_content article.title
    expect(page).not_to have_link(href: "/articles/#{article.id}/edit")
    expect(page).not_to have_css('.button-delete')
    expect(page).to have_content "Author: #{article.user.first_name} #{article.user.last_name}"
    expect(page).to have_content "Posted on #{article.created_at.strftime('%H:%M %d %B %Y')}"
    expect(page).to have_content article.body
  end
end
