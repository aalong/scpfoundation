class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :user_locale
  around_filter :set_time_zone

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(User::PROPERTIES - User::PROTECTED_PROPERTIES) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :real_name, :about) }
  end

  def set_time_zone(&block)
    if current_user
      Time.use_zone(current_user.timezone, &block)
    else
      Time.use_zone(ENV['default_timezone'], &block)
    end
  end

  def user_locale
    if params[:locale] && %W(en ru).include?(params[:locale])
      I18n.locale = params[:locale]
    elsif user_signed_in?
      I18n.locale = current_user.locale
    else
      I18n.locale = extract_locale
    end
  end

  def extract_locale
    if request.env['HTTP_ACCEPT_LANGUAGE']
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[en|ru]{2}/).first
    else
      I18n.default_locale
    end
  end
end
