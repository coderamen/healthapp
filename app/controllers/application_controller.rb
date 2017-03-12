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
    Time.local(params[:year].to_i, params[:month].to_i, params[:day].to_i, params[:hour].to_i, params[:minute].to_i, 0)
  end

end
