class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  protected
  def auth_admin!
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
