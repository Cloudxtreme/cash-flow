class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize_as_admin
    unless current_user.is? :admin
      redirect_to root_url, :alert => 'Not authorized to view this page.'
    end
  end

  def after_sign_in_path_for(resource)
    case current_user.role
      when 'admin'
        dashboard_path
      else
        root_url
    end
  end
  
end