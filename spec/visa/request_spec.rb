require 'spec_helper'

RSpec.describe Visa::Request do
  describe '#valid?' do
    let(:environment) { {'rack.input' => StringIO.new('')} }
    let(:request)     { Visa::Request.new environment }

    before :each do
      environment['QUERY_STRING'] = <<-STR
access_token=1234567890123456789012345678901234567890123456789012345678
      STR

      allow(Visa::Token).to receive(:find_by_credentials).and_return(nil)
    end

    it 'sources credentials from the access_token parameter' do
      expect(Visa::Token).to receive(:find_by_credentials).
        with('1234567890123456', '789012345678901234567890123456789012345678').
        and_return(nil)

      request.valid?
    end

    it 'returns true when a matching token is found' do
      allow(Visa::Token).to receive(:find_by_credentials).
        and_return(double('token', last_requested_at: nil))

      expect(request).to be_valid
    end

    it 'returns true when a matching token is less than two weeks old' do
      allow(Visa::Token).to receive(:find_by_credentials).
        and_return(double('token', last_requested_at: 13.days.ago))

      expect(request).to be_valid
    end

    it 'returns false when no token is found' do
      allow(Visa::Token).to receive(:find_by_credentials).
        and_return(nil)

      expect(request).to_not be_valid
    end

    it 'returns false when a matching token is more than two weeks old' do
      allow(Visa::Token).to receive(:find_by_credentials).
        and_return(double('token', last_requested_at: 15.days.ago))

      expect(request).to_not be_valid
    end
  end
end
