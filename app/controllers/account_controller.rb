class AccountController < ApplicationController
  before_action :verify_user, only: [:index]

  def index
    @orders_active = Order.where(user_id: current_user.id, status: "active")
    @orders_complete = Order.where(user_id: current_user.id, status: "completed").order(updated_at: :desc)
  end

  private
  def verify_user
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end