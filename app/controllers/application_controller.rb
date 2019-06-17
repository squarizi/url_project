class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_error
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::RoutingError, with: :render_not_found
    rescue_from ActionController::UnknownController, with: :render_not_found
    rescue_from AbstractController::ActionNotFound, with: :render_not_found
  end

  private

  def render_error(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: "errors/error_500", status: 500 }
      format.all { render nothing: true, status: 500 }
    end
  end

  def render_not_found(exception)
    @not_found_path = request.url
    @error_message = exception ? exception.message : nil
    respond_to do |format|
      format.html { render template: "errors/error_404", status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end
end
