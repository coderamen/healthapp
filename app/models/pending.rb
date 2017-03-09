class Pending < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  # when 'waiting', it means that the user is still waiting for a confirmed_activity
  # when 'successful', it means that the user has already got a confirmed_activity for that particular pending
  enum status[:waiting, :successful]

  #validations
  validates :activity_id, :user_id, :city, :datetime, :status, presence: true

  # since we've got 2 pending table joins in matches table, we need to create a method to get a pending's matches
  def potential_matches
    user_declined = MatchStatus.where(pending_viewer_id: self.id, status: declined)
  end
end
