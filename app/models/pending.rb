class Pending < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  # when 'waiting', it means that the user is still waiting for a confirmed_activity
  # when 'successful', it means that the user has already got a confirmed_activity for that particular pending
  enum status: [:waiting, :successful]

  #validations
  validates :activity_id, :user_id, :city, :datetime, :status, presence: true

  # accessor for new pending form
  attr_accessor :year, :month, :day, :hour, :minute

  # get datetime object from separated date and time values
  def self.get_datetime(params)
    Time.local(params[:year].to_i, params[:month].to_i, params[:day].to_i, params[:hour].to_i, params[:minute].to_i, 0)
  end

  # since we've got 2 pending table joins in matches table, we need to create a method to get a pending's matches
  def potential_matches
    all_unavailable_id = get_unavailable_matches_id
    # add the current pending id into declined_pendings_id because we don't want the user to be able to accept him/herself
    all_unavailable_id << self.id
    byebug
    all_similar_pendings = Pending.joins(:user).where(
      activity_id: self.activity_id,
      city: self.city,
      datetime: self.datetime,
      status: "waiting",
      # user attributes
      users: {
        age_range: self.user.age_range,
        stamina: self.user.stamina,
        strength: self.user.strength,
        agility: self.user.agility
      }
    )

    return all_similar_pendings.where.not(id: all_unavailable_id)
  end

  def delete_related_matches_matchstatuses
    # delete all related matchstatus to this pending
    MatchStatus.where(pending_viewer_id: self.id).delete_all
    MatchStatus.where(pending_viewed_id: self.id).delete_all

    # delete all related matches to this pending
    Match.where(user1_pending_id: self.id).delete_all
    Match.where(user2_pending_id: self.id).delete_all
  end

  private

  def get_unavailable_matches_id
    responded_by_user = MatchStatus.where(pending_viewer_id: self.id).pluck(:pending_viewed_id)
    declined_by_others = MatchStatus.where(pending_viewed_id: self.id, status: :"declined").pluck(:pending_viewer_id)

    declined_by_others.each do |id|
      unless id.include?(responded_by_user)
        responded_by_user << id
      end
    end

    return responded_by_user
  end
  
end
