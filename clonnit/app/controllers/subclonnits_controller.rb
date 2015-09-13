# Subclonnits controller
class SubclonnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subclonnit, only: [:show]

  # GET /subclonnits/1
  def show
  end

  # GET /subclonnits/new
  def new
    @subclonnit = Subclonnit.new
  end

  # POST /subclonnits
  def create
    result, @subclonnit = CreateSubclonnitService.new(
      subclonnit_params.merge(user: current_user)
    ).call

    if result == :success
      redirect_to @subclonnit, notice: t('subclonnits.successfully_created')
    else
      render :new
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subclonnit
    @subclonnit = Subclonnit.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def subclonnit_params
    params.require(:subclonnit).permit(:name, :description)
  end
end
