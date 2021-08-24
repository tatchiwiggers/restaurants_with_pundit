class ApplicationController < ActionController::Base
  # before you do any actions, make sure the user is authenticated
  before_action :authenticate_user!

  # here we include pundit in our app, bc we wanna use it for every action
  include Pundit

  # Pundit: white-list approach.
  # which means that every action will be denied unless i explicitly allow it
  # so after every action, a method called :verify_authorized will be called
  # which will call pundit - for every action except :index unless you
  # skip pundit?, which is this private method here that states that if you are
  # in the devise controller (that is, if you have a user that need to sign up)
  # or if you are in the controller admin or pages, then skip pundit.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
