# Posts controller
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :toggle_upvote, :toggle_downvote, :destroy]
  before_action :set_subclonnit

  # GET /subclonnits/:subclonnit_id/posts/1
  def show
  end

  # GET /subclonnits/:subclonnit_id/posts/new
  def new
    @post = Post.new
  end

  # POST /subclonnits/:subclonnit_id/posts
  def create
    result, @post = CreatePostService.new(
      post_params.merge user:       current_user,
                        subclonnit: @subclonnit
    ).call

    if result == :success
      redirect_to [@subclonnit, @post], notice: t('posts.successfully_created')
    else
      render :new
    end
  end

  # POST /subclonnits/:subclonnit_id/posts/:id/toggle_upvote
  def toggle_upvote
    _, @upvote = ToggleUpvoteService.new(
      user: current_user,
      post: @post
    ).call
  end

  # POST /subclonnits/:subclonnit_id/posts/:id/toggle_downvote
  def toggle_downvote
    _, @downvote = ToggleDownvoteService.new(
      user: current_user,
      post: @post
    ).call
  end

  # DELETE /subclonnits/:subclonnit_id/posts/1
  def destroy
    result, @post = DestroyPostService.new(
      user: current_user,
      post: @post
    ).call

    case result
    when :success
      redirect_to subclonnit_path(@subclonnit),
                  notice: t('posts.successfully_destroyed')
    when :forbidden
      render status: :forbidden, nothing: true
    when :error
      # Unexpected case
      redirect_to subclonnit_path(@subclonnit),
                  notice: @post.errors.full_messages.join(', ')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def set_subclonnit
    @subclonnit = Subclonnit.find(params[:subclonnit_id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :url, :text)
  end
end
