# Frontpage controller
class FrontpageController < ApplicationController
  # Anon user can view frontpage
  skip_action_callback :authenticate_user!, only: [:show]

  def show
    page = params[:page].nil? ? 1 : params[:page]
    _, @posts = GetFrontpagePageService.new(
      page: page, user: current_user
    ).call
  end
end
