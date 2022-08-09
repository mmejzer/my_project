# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 1 }

  VALID_STATUSES = %w[public draft].freeze

  validates :status, inclusion: { in: VALID_STATUSES }

  def draft?
    status == 'draft'
  end
end
