class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private

  def user_not_authorized
    flash[:alert]="You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
