# Subscriptions controller
class SubscriptionsController < ApplicationController
  before_action :set_user

  # GET /users/:user_id/subscriptions
  def index
    page = params[:page].nil? ? 1 : params[:page]
    @subscriptions = @user
                     .subscriptions
                     .includes(:subclonnit)
                     .page page
  end

  # POST /users/:user_id/subscriptions
  def create
    result, @subscription = CreateSubscriptionService.new(
      subscription_params.merge session_user:     current_user,
                                subscribing_user: @user
    ).call

    case result
    when :success
      redirect_to [@user, :subscriptions],
                  notice: t('subscriptions.successfully_created')
    when :forbidden
      render status: :forbidden, nothing: true
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def subscription_params
    params.require(:subscription).permit(:subclonnit_id)
  end
end
