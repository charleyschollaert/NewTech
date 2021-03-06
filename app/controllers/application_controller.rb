class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    sign_out :user if user_signed_in?
    redirect_to new_user_session_path, alert: exception.message

  end

  def authenticate_admin_user
    unless current_user && current_user.is_admin?
      raise CanCan::AccessDenied , "AccessDenied"
    end
  end

end
