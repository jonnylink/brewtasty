class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def check_user(object)
    if !current_user || (current_user.id != object.user_id && current_user.admin === false)
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end
end
