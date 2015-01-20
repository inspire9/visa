class ApplicationController < ActionController::Base
  private

  def authenticate_user!
    if user_signed_in?
      visa_request.touch
    else
      render text: 'Unauthorised', status: 401
    end
  end

  def current_user
    visa_request.tokenable
  end

  def visa_request
    @visa_request ||= Visa::Request.new request.env
  end

  def user_signed_in?
    visa_request.valid?
  end
end
