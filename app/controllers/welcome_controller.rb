class WelcomeController < ApplicationController
  def index
  end

  def dashboard
    current_user_authorised?(params[:id], root_path)

    @pending = Pending.new
  end
end
