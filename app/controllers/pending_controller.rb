class PendingController < ApplicationController
  def new
    @pending = Pending.new
  end

  def create
    @pending = Pending.new(pending_params)

    if @pending
      redirect_to pending_path(@pending)
    else
      redirect_to new_pending_path
    end

  end

  def show
  end

  def destroy
  end

  private

  def pending_params
    return_hash = params.require(:pending).permit(:city, :datetime)
    # if the input activity is a long string, and not a number
    if params[:pending][:activity].to_i == 0
      find_if_exists = Activity.where(name: params[:pending][:activity])

      # if the user specifies an activity that already exists
      if find_if_exists == []
        new_activity = Activity.create(name: params[:pending][:activity].capitalize)
        return_hash[:activity_id] = new_activity.id
      else
        return_hash[:activity_id] = find_if_exists[0].id
      end

    else
      return_hash[:activity_id] = params[:pending][:activity].to_i
    end

  end

end
