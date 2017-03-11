class ConfirmedActivitiesController < ApplicationController
  def create
    @confirmed_activity = ConfirmedActivity.new(confirmed_activities_params)

    if !pending_attrs
      flash[:danger] = "You need to specify an activity!"
      return redirect_to user_match_path(current_user.id, params[:match_id])
    end

    if @confirmed_activity.save
      flash[:success] = "Created activity! Now waiting for other user to confirm."
    else
      flash[:danger] = "Unable to create confirmed_activity"
    end

    redirect_to user_match_path(current_user.id, params[:match_id])
  end

  def update
  end

  private

  def confirmed_activities_params
    attr_hash = params.require(:confirmed_activity).permit(:location, :duration_in_hours, :user1_confirm, :user2_confirm)

    attr_hash[:datetime] = get_datetime(params[:confirmed_activity])

    if params[:pending][:activity_id] == "0"
      # condition for when an other activity is specified or none
      if params[:pending][:activity] != ""
        activity_id = Activity.get_id(params[:pending][:activity]) 
        return_hash[:activity_id] = activity_id
      else
        return false
      end
    else
      return_hash[:activity_id] = params[:pending][:activity_id].to_i
    end

    return attr_hash
  end
end
