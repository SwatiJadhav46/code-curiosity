class RedeemController < ApplicationController
  before_action :work_in_progress
  before_action :authenticate_user!

  def create
    @redeem = current_user.redeem_requests.build(redeem_params)

    if @redeem.save
      flash[:notice] = I18n.t('redeem.request_created')
    end
  end

  private

  def redeem_params
    params.fetch(:redeem_request).permit(:points)
  end

end
