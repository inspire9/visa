require 'spec_helper'

RSpec.describe 'Request integration', type: :request do
  let(:token) { Visa::Token.create tokenable: User.create }

  def get_root_with_token(token)
    if Rails::VERSION::MAJOR == 4
      get '/', access_token: token
    else
      get '/', params: {access_token: token}
    end
  end

  it 'accepts valid tokens' do
    get_root_with_token "#{token.client_id}#{token.secret}"

    expect(response.status).to eq(200)
  end

  it 'returns 401 when the token is invalid' do
    get_root_with_token "#{token.client_id}this-is-invalid"

    expect(response.status).to eq(401)
  end

  it 'returns 401 when the token has not been used in two weeks' do
    token.update_column :last_requested_at, 15.days.ago

    get_root_with_token "#{token.client_id}#{token.secret}"

    expect(response.status).to eq(401)
  end

  it 'updates the last_requested_at column' do
    get_root_with_token "#{token.client_id}#{token.secret}"

    token.reload

    expect(token.last_requested_at).to_not be_nil
  end
end
