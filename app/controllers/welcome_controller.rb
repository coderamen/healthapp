class WelcomeController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index]

  def index
    @user = current_user
  end


  def dashboard
    @pending = Pending.new

    @matches = Match.where(user1_id: current_user.id).or(Match.where(user2_id: current_user.id))
    @confirmed_activities = ConfirmedActivity.joins(:match).where(matches: { user1_id: current_user.id }).or(ConfirmedActivity.joins(:match).where(matches: { user2_id: current_user.id }))
  end
end
