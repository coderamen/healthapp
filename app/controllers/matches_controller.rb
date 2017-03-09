class MatchesController < ApplicationController
  before_action :require_login

  def show
    current_user_authorised?(params[:user_id], root_path)

    match = Match.find_by_id(params[:id])
    user_in_match? = current_user.id == @match.user1_id || current_user.id == @match.user2_id

    if user_in_match?
      @match = match
    else
      flash[:danger] = "Unauthorised action."
      redirect_to root_path
    end
  end
end
