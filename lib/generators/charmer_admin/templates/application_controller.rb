class ApplicationController < ActionController::API
  include ActionController::Cookies

  attr_reader :current_admin_user
  before_action :set_current_admin_user

  def set_current_admin_user
    admin_cookies = ''
    admin_cookies = cookies[:stagingAuthToken] if Rails.env.staging?
    admin_cookies = cookies[:authToken] if Rails.env.production?
    @current_admin_user ||= CharmerAdmin::V1::Authentication::RequestService.call(admin_cookies).result
  end

  def admin_can?(action, obj)
    if @current_admin_user
      Ability.new(@current_admin_user).can?(action, obj)
    end
  end
end
