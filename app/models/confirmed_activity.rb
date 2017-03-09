class ConfirmedActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :match
  
end
