class MatchesController < ApplicationController
  before_action :require_login
  before_action :require_user_details

  def index
    current_user_authorised?(params[:user_id], root_path)

    user_in_user1 = Match.where(user1_id: params[:user_id])
    user_in_user2 = Match.where(user2_id: params[:user_id])

    # have an array of all matches where the user is involved
    @matches = user_in_user1
    @matches << user_in_user2 if !user_in_user2

    if @matches != []
      # order the matches based on created_at
      @matches = @matches.order('created_at desc')
    else
      flash[:danger] = "No matches available"
      redirect_to root_path
    end
  end

  def show
    current_user_authorised?(params[:user_id], root_path)

    match = Match.find_by_id(params[:id])

    if current_user_authorised_for_match?(match)
      @match = match
    end
  end

end
