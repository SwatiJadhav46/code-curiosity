class SubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_user_id_with_current_user

  def subscribe

    @round = Round.order_by(created_at: :desc).first

    if @round.subscriptions.where(:user_id => current_user).any?
      puts "Already Subscribed"
    else
      if current_user.points>=WALLET_CONFIG['subscription_amount']   
        current_user.subscriptions.create(round: @round)
        redirect_to users_path
      end
    end
  end

  private

  def check_user_id_with_current_user
    unless params[:id] == current_user.id
      redirect_to root_path 
    end
  end

end
