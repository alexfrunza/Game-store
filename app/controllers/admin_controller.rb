class AdminController < ApplicationController
  before_action :require_admin

  def index
  end

  private
  def require_admin
    unless user_signed_in? and current_user.admin?
      redirect_to root_path
    end
  end
end