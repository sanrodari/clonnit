# Service to associate a newly created user with the default subclonnits
class AssociateNewUserDefaultSubclonnits
  def initialize(params)
    @user = params[:user]
  end

  def call
    @user.subclonnits = Subclonnit.default
  end
end
