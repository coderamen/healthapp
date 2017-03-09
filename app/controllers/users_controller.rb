class UsersController < Clearance::UsersController

 def new
   @user = user.new
 end

 def create
      @user = User.new(user_params)
   if @user.save
     log_in @user
     flash[:success] = "healthapp account has been successfully created"
     redirect_to @user
   else
     render 'new'
   end
 end

 def show
   @user = User.find(params[:id])
 end

 def edit
   @user = User.find(params[:id])
 end

 def update
   update_hash = update_user_params
		@user = User.find_by_id(params[:id])
 end

 def destroy
   current_user_authorised?(params[:id], user_path(id: params[:id]))

		user = User.find_by_id(params[:id])
		sign_out
		user.authentications.delete_all
		user.destroy
		redirect_to root_path
 end
end
