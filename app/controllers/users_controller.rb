class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    # form_withの引数で必要となるUserオブジェクトを作成する
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
