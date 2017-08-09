class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActionController::InvalidAuthenticityToken, with: :redirect_to_referer_or_path

  def redirect_to_referer_or_path
    flash[:notice] = "Please try again."
    redirect_to request.referer
  end

  def render_not_found(status = :not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end

  # before_action :configure_devise_permitted_parameters, if: :devise_controller?

  # def configure_devise_permitted_parameters
  #   registration_params = [:name, :email, :password, :password_confirmation]
  #
  #   if params[:action] == 'update'
  #     devise_parameter_sanitizer.for(:account_update) do
  #       |u| u.permit(registration_params << :current_password)
  #     end
  #   elsif params[:action] == 'create'
  #     devise_parameter_sanitizer.for(:sign_up) do
  #       |u| u.permit(registration_params)
  #     end
  #   end
  # end

end
