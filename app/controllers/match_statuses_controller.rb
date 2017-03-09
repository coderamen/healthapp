class MatchStatusesController < ApplicationController
  def create
    @match_status = MatchStatus.new(match_status_params)

    if @match_status.save
      flash[:success] = "#{params[:status].capitalize}!"
      redirect_to user_pending_path(user_id: current_user.id, id: params[:pending_viewer_id].to_i)

      # add method to check the reversed id statuses
      if @match_status.opposite_match_status_accepted?
        @match_status.create_new_match
      end
    else
      flash[:danger] = "Unable to make changes"
      redirect_to user_pending_path(user_id: current_user.id, id: params[:pending_viewer_id].to_i)
    end

  end

  private

  def match_status_params
    hash = {
      pending_viewer_id: params[:pending_viewer_id],
      pending_viewed_id: params[:pending_viewed_id],
      status: params[:status]
    }
  end
end
