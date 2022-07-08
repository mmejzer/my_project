class Article < ApplicationRecord
	belongs_to :user

	validates :title, presence: true
	validates :body, presence: true, length: { minimum: 1 }

	VALID_STATUSES = ['public', 'draft']

		validates :status, inclusion: { in: VALID_STATUSES }

	def draft?
    	status == 'draft'
	end

    def public_count
      self.where(status: 'public').count
    end
end