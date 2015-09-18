# Service to create subclonnit
class CreateSubclonnitService
  def initialize(params)
    @name        = params[:name]
    @description = params[:description]
    @user        = params[:user]
  end

  def call
    subclonnit = Subclonnit.new(name: @name, description: @description)

    ActiveRecord::Base.transaction do
      subclonnit.save!
      Moderator.create!(subclonnit: subclonnit, user: @user)
    end
    [:success, subclonnit]
  rescue => e
    Rails.logger.debug e
    [:error, subclonnit]
  end
end
