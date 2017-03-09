class Activity < ApplicationRecord
  has_many :pendings
  has_many :confirmed_activities
end
