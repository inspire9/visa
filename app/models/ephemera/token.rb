class Ephemera::Token < ActiveRecord::Base
  self.table_name = 'ephemera_tokens'

  belongs_to :tokenable, polymorphic: true

  validates :tokenable,        presence: true
  validates :client_id,        presence: true, uniqueness: true
  validates :encrypted_secret, presence: true

  before_validation :set_client_id, on: :create
  before_validation :set_secret,    on: :create

  attr_reader :secret

  def self.find_by_credentials(client_id, secret)
    token = find_by client_id: client_id
    token && token.has_secret?(secret) ? token : nil
  end

  def has_secret?(secret)
    BCrypt::Password.new(encrypted_secret) == secret
  end

  private

  def encryption_cost
    Ephemera.encryption_cost || 10
  end

  def set_client_id
    self.client_id = SecureRandom.hex 16
  end

  def set_secret
    @secret               = SecureRandom.urlsafe_base64 32
    self.encrypted_secret = BCrypt::Password.create @secret,
      cost: encryption_cost
  end
end
