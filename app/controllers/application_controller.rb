class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, :alert => exception.message
  end

  def authorize_as_admin
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
  end

  def after_sign_in_path_for(resource)
    case current_user.role
      when 'admin'
        dashboard_path
      when 'silver'
        content_silver_path
      when 'gold'
        content_gold_path
      when 'platinum'
        content_platinum_path
      else
        root_path
    end
  end
  
end