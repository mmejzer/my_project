# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:article) { create(:article, user: user) }

  scenario 'Show as author when mine comment' do
    sign_in user
    comment = described_class.create(user: user, article: article, body: 'Text comment')
    visit article_path(article)

    expect(page).to have_content "#{comment.user.first_name} #{comment.user.last_name}"
    element = find('.right-side-buttons')
    expect(element).to have_css('.edit-link')
    expect(element).to have_css('.button-delete')
    expect(page).to have_content comment.body
    expect(page).to have_content "Posted on #{comment.created_at.strftime('%H:%M %d %B %Y')}"
  end

  scenario 'Show as authorized user when not mine comment (not be author comment)' do
    sign_in user2
    comment = described_class.create(user: user, article: article, body: 'Text comment')
    visit article_path(article)

    expect(page).to have_content "#{comment.user.first_name} #{comment.user.last_name}"
    expect(page).not_to have_css('.edit-link')
    expect(page).not_to have_css('.button-delete')
    expect(page).to have_content comment.body
    expect(page).to have_content "Posted on #{comment.created_at.strftime('%H:%M %d %B %Y')}"
  end

  scenario 'Show as not authorized user when show guest' do
    comment = described_class.create(user: user, article: article, body: 'Text comment')
    visit article_path(article)

    expect(page).to have_content "#{comment.user.first_name} #{comment.user.last_name}"
    expect(page).not_to have_css('.edit-link')
    expect(page).not_to have_css('.button-delete')
    expect(page).to have_content comment.body
    expect(page).to have_content "Posted on #{comment.created_at.strftime('%H:%M %d %B %Y')}"
    expect(page).to have_content 'You must be logged in to leave a comment. Do you want to login/register?'
    expect(page).to have_link('login', href: '/users/sign_in')
    expect(page).to have_link('register', href: '/users/sign_up')
  end
end
