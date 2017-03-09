class Match < ApplicationRecord
  belongs_to :confirmed_activity

  validates :user1_id, :user2_id, :user1_pending_id, :user2_pending_id, presence: true
  validates :user1_pending_id, uniqueness: { scope: :user2_pending_id }
  validate :reversed_unique_ids

  def reversed_unique_ids
    if Match.find_by(user1_pending_id: user2_pending_id, user2_pending_id: user1_pending_id)
      errors.add(user1_pending_id, "Match already exists for this particular combinaton of pendings")
    end
  end  
end

