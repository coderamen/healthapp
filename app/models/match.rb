class Match < ApplicationRecord
  belongs_to :confirmed_activity

  validates :user1_id, :user2_id, :user1_pending_id, :user2_pending_id, presence: true
  
end

