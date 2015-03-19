class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  def index
    authorize! :view,:users
    @user=User.all.paginate(:page => params[:page], :per_page => 5)
  end

  def destroy
    @user=User.find(params[:id])
    authorize! :destroy,@user
    @user.destroy
    redirect_to :back
  end

  def edit

  end


  def update
    @user=User.find(params[:id])
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to users_path , method: :get, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

##edit check admin