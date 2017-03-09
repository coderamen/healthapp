class MatchStatus < ApplicationRecord
  enum status: [:declined, :accepted]

  #validations
  validates :pending_viewer_id, :pending_viewed_id, :status, presence: true
end
