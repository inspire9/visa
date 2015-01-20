class Visa::Request
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
      environment[Visa.request_header] || ''

    [string[0..15], string[16..57]]
  end

  def not_too_old?
    time = token.last_requested_at || token.created_at
    time > Visa.timeout.ago
  end

  def request
    @request ||= Rack::Request.new environment
  end

  def token
    @token ||= Visa::Token.find_by_credentials *credentials
  end
end
