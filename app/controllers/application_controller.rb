class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def require_login
    unless signed_in?
      flash[:danger] = "You need to sign in first!"
      redirect_to sign_in_path
    end
  end

  def require_user_details
    if current_user.has_nil_attributes
      flash[:danger] = "You're missing some details"
      redirect_to edit_user_path(current_user)
    end
  end

  def current_user_authorised?(id, path)
    if current_user.id != id.to_i
      flash[:danger] = "Unathorised action."
      return redirect_to path
    end
  end

  def current_user_authorised_for_match?(match)
    if match && (current_user.id == match.user1_id || current_user.id == match.user2_id)
      return true
    else
      flash[:danger] = "Unathorised action."
      return redirect_to root_path
    end
  end
  
  # get datetime object from separated date and time values
  def get_datetime(params)
    date = params[:date]
    time = params[:time]
    
    day = date[0..1].to_i
    month = date[3..4].to_i
    year = date[6..9].to_i

    if time.length == 8
      hour = time[0..1].to_i
      min = time[3..4].to_i

      if time[6..7] == "PM"
        hour += 12
      end
    elsif time.length == 7
      hour = time[0].to_i
      min = time[2..3].to_i

      if time[5..6] == "PM"
        hour += 12
      end
    end

    Time.local(year, month, day, hour, min, 0)
  end

end
