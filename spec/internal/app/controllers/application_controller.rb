class ApplicationController < ActionController::Base
  private

  def authenticate_user!
    return if user_signed_in?

    render text: 'Unauthorised', status: 401
  end

  def current_user
    ephemera_request.tokenable
  end

  def ephemera_request
    @ephemera_request ||= Ephemera::Request.new request.env
  end

  def user_signed_in?
    ephemera_request.valid?
  end
end
