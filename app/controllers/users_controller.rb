class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update]
  before_action :auth_admin!

  def index
    @users = []
    [4,1,3,2].each do |state|
      @users.concat User.where(study_state_id: state).to_a
    end
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
