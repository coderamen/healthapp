class MatchesController < ApplicationController
  before_action :require_login

  def show
    current_user_authorised?(params[:user_id], root_path)
    
  end
end
