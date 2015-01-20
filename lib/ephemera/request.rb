class Ephemera::Request
  delegate :tokenable, to: :token

  def initialize(environment)
    @environment = environment
  end

  def touch
    token.touch :last_requested_at
  end

  def valid?
    token.present? && not_too_old?
  end

  private

  attr_reader :environment

  def credentials
    string = request.params['access_token'] ||
      request.headers[Ephemera.request_header]

    [string[0..15], string[16..57]]
  end

  def not_too_old?
    time = token.last_requested_at
    time.nil? || (time > Ephemera.timeout.ago)
  end

  def request
    @request ||= Rack::Request.new environment
  end

  def token
    @token ||= Ephemera::Token.find_by_credentials *credentials
  end
end
