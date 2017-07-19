class UsersController < ApplicationController

  def show
  end

  def edit
  end

  def update
    if current_user.update_without_current_password(user_params)
      redirect_to root_path, success: "Successfully edit your profile."
    else
      flash.now[:alert] = "Failure edit your profile."
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :user_image, :email, :password, :member, :profile, :works)
  end

end
