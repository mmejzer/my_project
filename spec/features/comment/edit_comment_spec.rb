# frozen_string_literal: true

require 'rails_helper'

describe Comment do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  feature 'Edit comment as author' do
    before do
      sign_in user
      visit article_path(article)
    end

    scenario 'when valid attribute', js: true do
      described_class.create(user: user, article: article, body: 'Text comment')
      visit article_path(article)

      find('.right-side-buttons').find('.edit-link').click

      find('.js-edit-comment-form').fill_in 'Body', with: 'Test edit comment text'
      find('.js-edit-comment-form').click_button 'Update Comment'

      expect(page).to have_content 'Your comment was edited'
      expect(page).to have_content "#{user.first_name} #{user.last_name}"
      expect(page).to have_content 'Test edit comment text'
    end

    scenario 'when not valid attribute', js: true do
      described_class.create(user: user, article: article, body: 'Text comment')
      visit article_path(article)

      find('.right-side-buttons').find('.edit-link').click

      find('.js-edit-comment-form').fill_in 'Body', with: ''
      find('.js-edit-comment-form').click_button 'Update Comment'

      expect(page).not_to have_content 'Your comment was edited'
    end
  end
end
