require 'spec_helper'

RSpec.describe Ephemera::Token, type: :model do
  let(:token) { Ephemera::Token.create tokenable: User.create }

  describe '.find_by_credentials' do
    it 'returns the matching token' do
      existing_token = Ephemera::Token.find_by_credentials token.client_id,
        token.secret
      expect(existing_token).to eq(token)
    end

    it 'returns nil when the client id is wrong' do
      existing_token = Ephemera::Token.find_by_credentials 'foo', token.secret
      expect(existing_token).to be_nil
    end

    it 'returns nil when the secret is wrong' do
      existing_token = Ephemera::Token.find_by_credentials token.client_id,
        'foo'
      expect(existing_token).to be_nil
    end
  end

  describe '#client_id' do
    it 'is populated on creation' do
      expect(token.client_id).to be_present
    end
  end

  describe '#secret' do
    it 'is populated on creation' do
      expect(token.secret).to be_present
    end

    it 'is not persisted' do
      existing_token = Ephemera::Token.find token.id
      expect(existing_token.secret).to be_nil
    end
  end

  describe '#has_secret?' do
    it 'matches against the original secret' do
      expect(token.has_secret?(token.secret)).to eq(true)
    end

    it 'returns false with different secrets' do
      expect(token.has_secret?('foo')).to eq(false)
    end
  end
end
