class MatchesController < ApplicationController
  before_action :require_login
  before_action :require_user_details

  def index
    current_user_authorised?(params[:user_id], root_path)

    user_in_user1 = Match.where(user1_id: params[:user_id])
    user_in_user2 = Match.where(user2_id: params[:user_id])

    # have an array of all matches where the user is involved
    @matches = user_in_user1
    @matches << user_in_user2

    # order the matches based on created_at
    @matches = @matches.order('created_at desc')
  end

  def show
    current_user_authorised?(params[:user_id], root_path)

    match = Match.find_by_id(params[:id])

    if match && (current_user.id == match.user1_id || current_user.id == match.user2_id)
      @match = match
    else
      flash[:danger] = "Unauthorised action."
      redirect_to root_path
    end
  end

end
