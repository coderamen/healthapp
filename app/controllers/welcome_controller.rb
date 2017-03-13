class WelcomeController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index]

  def index
    @user = current_user
  end

  def dashboard    
    @pending = Pending.new
  end
end
