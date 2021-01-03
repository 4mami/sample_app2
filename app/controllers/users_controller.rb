class UsersController < ApplicationController
before_action :logged_in_user, only: [:index, :edit, :update]
before_action :correct_user, only: [:edit, :update]

  def index
    # params[:page]はwill_paginateによって自動的に生成される
    @users = User.paginate(page: params[:page])
  end

  def show
    # Usersコントローラにリクエストが正常に送信されると、params[:id]の部分はユーザーidに変わる
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

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      # application_controllerでsessions_helperをインクルードしてるので、「logged_in?」が使える
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
