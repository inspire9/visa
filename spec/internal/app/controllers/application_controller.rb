class ApplicationController < ActionController::Base
  private

  def authenticate_user!
    if user_signed_in?
      ephemera_request.touch
    else
      render text: 'Unauthorised', status: 401
    end
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
