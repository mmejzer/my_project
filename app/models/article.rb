# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  VALID_STATUSES = %w[public draft].freeze

  validates :status, inclusion: { in: VALID_STATUSES }

  def draft?
    status == 'draft'
  end
end
