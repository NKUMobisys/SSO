class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update]

  def index
  end

  def edit
  end

  def show
    redirect_to root_path
  end

  def update
    @user.update(update_params)
    if @user.errors.empty?
      flash.now[:success] = true
    end
    render 'edit'
  end

protected
  def set_user
    @user = User.find(params[:id])
  end

  def update_params
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    params.require("user").permit(:account, :email, :name, :nickname, :stu_id, :study_state_id, :password, :password_confirmation)
  end
end
