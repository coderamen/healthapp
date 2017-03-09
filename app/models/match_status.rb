class MatchStatus < ApplicationRecord
  enum status: [:declined, :accepted]
end
