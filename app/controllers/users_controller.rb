class UsersController < ApplicationController
  before_action :set_user, only: [:destroy, :make_admin, :remove_admin]
  before_action :require_admin, only: [:destroy, :make_admin, :remove_admin]

  def destroy
    Order.where(user_id: @user.id).map(&:destroy)
    @user.destroy
    redirect_to admin_users_path
  end

  def make_admin
    @user.update( :admin => true)
    redirect_to admin_users_path
  end

  def remove_admin
    @user.update( :admin => false)
    redirect_to admin_users_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    unless user_signed_in? and current_user.admin?
      redirect_to root_path
    end
  end
end

