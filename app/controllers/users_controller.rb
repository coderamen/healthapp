class UsersController < Clearance::UsersController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = "healthapp account has been successfully created"
      redirect_to root_path
    else
      render 'users/new'
      flash[:danger] = "error in creation of account"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Update successful"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Update unsuccessful"
      redirect_to edit_user_path(@user)
    end

  end

  def destroy
		user = User.find_by_id(params[:id])
		sign_out
		user.authentications.delete_all
		user.destroy
		redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :city, :state, :country, :age_range, :physique, :additional_health_problems, :weekly_activity_hours)
  end
end
