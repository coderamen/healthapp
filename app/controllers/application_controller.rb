class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def require_login
    unless signed_in?
      flash[:danger] = "You need to sign in first!"
      redirect_to sign_in_path
    end
  end

  def current_user_authorised?(id, path)
    if current_user.id != id.to_i
      flash[:danger] = "Unathorised action."
      return redirect_to path
    end
  end
  
end
