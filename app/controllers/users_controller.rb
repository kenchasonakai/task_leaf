class UsersController < ApplicationController
  skip_before_action :require_login, only: %w[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, success: 'TaskLeafへようこそ'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    raise ActionController::RoutingError, 'Not Found' if @user != current_user
  end

  def update
    @user = User.find(params[:id])
    raise ActionController::RoutingError, 'Not Found' if @user != current_user

    if @user.update(user_params)
      redirect_to @user, success: 'ユーザー情報を更新しました'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end