class ConfirmedActivitiesController < ApplicationController
  before_action :require_login
  before_action :require_user_details

  def create
    current_user_authorised_for_match?(Match.find_by_id(params[:match_id]))

    @confirmed_activity = ConfirmedActivity.new(confirmed_activities_params)
    @confirmed_activity.match_id = params[:match_id]

    confirmed_activity_attrs = confirmed_activities_params

    if !confirmed_activity_attrs
      flash[:danger] = "You need to specify an activity!"
      return redirect_to user_match_path(current_user.id, params[:match_id])
    end
    byebug
    if @confirmed_activity.save
      flash[:success] = "Created activity! Now waiting for other user to confirm."
    else
      flash[:danger] = "Unable to create confirmed_activity"
    end

    redirect_to user_match_path(current_user.id, params[:match_id])
  end

  def destroy
  end

  def confirm
  end

  private

  def confirmed_activities_params
    attr_hash = {
      duration_in_hours: params[:confirmed_activity][:duration_in_hours].to_i,
      location: params[:confirmed_activity][:location],
      user1_confirm: params[:confirmed_activity][:user1_confirm],
      user2_confirm: params[:confirmed_activity][:user2_confirm]
    }

    attr_hash[:datetime] = get_datetime(params[:confirmed_activity])

    if params[:confirmed_activity][:activity_id] == "0"
      # condition for when an other activity is specified or none
      if params[:confirmed_activity][:activity] != ""
        activity_id = Activity.get_id(params[:confirmed_activity][:activity]) 
        return_hash[:activity_id] = activity_id
      else
        return false
      end
    else
      attr_hash[:activity_id] = params[:confirmed_activity][:activity_id].to_i
    end

    return attr_hash
  end
end
