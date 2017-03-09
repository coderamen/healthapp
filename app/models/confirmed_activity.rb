class ConfirmedActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :match
  
  validates :match_id, :activity_id, :location, :datetime, :duration, presence: true 
end
