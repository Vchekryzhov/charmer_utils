class ApiController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render(json: { error: exception.message }, status: :not_found)
  end

  rescue_from ArgumentError do |exception|
    render(json: { error: exception.message }, status: :argument_error)
  end

  rescue_from ActionController::BadRequest do |exception|
    render(json: { error: exception.message }, status: :bad_request)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def offset
    params[:offset]
  end

  def limit
    if params[:limit].present?
      params[:limit].to_i > 36 ? 36 : params[:limit]
    else
      36
    end
  end
end
