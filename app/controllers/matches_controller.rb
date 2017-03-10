class MatchesController < ApplicationController
  before_action :require_login
  before_action :require_user_details

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
