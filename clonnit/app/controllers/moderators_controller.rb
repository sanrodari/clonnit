# Moderators controller
class ModeratorsController < ApplicationController
  before_action :set_moderator, only: [:destroy]
  before_action :set_subclonnit

  # GET /subclonnits/:subclonnit_id/moderators
  def index
    @moderators = Moderator
                  .where(subclonnit: @subclonnit)
                  .includes(:user)

    @can_add = CreateModeratorService.can_add?(current_user, @subclonnit)
  end

  # GET /subclonnits/:subclonnit_id/moderators/new
  def new
    @moderator = Moderator.new
  end

  # POST /subclonnits/:subclonnit_id/moderators
  def create
    result, @moderator = CreateModeratorService.new(
      moderator_params.merge user:       current_user,
                             subclonnit: @subclonnit
    ).call

    case result
    when :success
      redirect_to subclonnit_moderators_path(@subclonnit),
                  notice: t('moderators.successfully_created')
    when :forbidden
      # TODO Send forbidden status code
    else
      render :new
    end
  end

  # DELETE /subclonnits/:subclonnit_id/moderators/:id
  def destroy
    # TODO Implement this
    fail 'TODO'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_moderator
    @moderator = Moderator.find(params[:id])
  end

  def set_subclonnit
    @subclonnit = Subclonnit.find(params[:subclonnit_id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def moderator_params
    params.require(:moderator).permit(:user_id)
  end
end
