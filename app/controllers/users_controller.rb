class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, success: 'TaskLeafへようこそ'
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end

def update
  @user = User.find(current_user.id)
  if @user.update(user_params)
    redirect_to @user, success: 'ユーザー情報を更新しました'
  else
    flash.now[:danger] = 'ユーザー情報の更新に失敗しました'
    render :edit
  end
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end
end
