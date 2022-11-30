# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let(:article) { create(:article, user: user) }

  scenario 'Edit comment as author when valid attribute' do
    sign_in user
    described_class.create(user: user, article: article, body: 'Text comment')
    visit article_path(article)

    find('.right-side-buttons').find('.edit-link').click
    find('.js-edit-comment-form').fill_in 'Body', with: 'Test edit comment text'
    find('.js-edit-comment-form').click_button 'Update Comment'

    expect(page).to have_content 'Your comment was edited'
    expect(page).to have_content "#{user.first_name} #{user.last_name}"
    expect(page).to have_content 'Test edit comment text'
  end

  scenario 'Edit comment as author when empty attribute', js: true do
    sign_in user
    described_class.create(user: user, article: article, body: 'Text comment')
    visit article_path(article)

    find('.right-side-buttons').find('.edit-link').click
    find('.js-edit-comment-form').fill_in 'Body', with: ''
    find('.js-edit-comment-form').click_button 'Update Comment'

    expect(page).not_to have_content 'Your comment was edited'
  end
end
