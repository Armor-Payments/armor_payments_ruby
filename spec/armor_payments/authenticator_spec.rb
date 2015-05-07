require 'spec_helper'
require 'armor_payments/authenticator'

module ArmorPayments
  describe Authenticator do
    let(:api_key) { 'my-api-key' }
    let(:api_secret) { 'my-secret-code' }
    let(:authenticator) { Authenticator.new(api_key, api_secret) }
    let(:given_time) { Time.new(2014, 2, 22, 12, 0, 0, "+00:00") }

    describe "#current_timestamp" do
      it "returns the current time in iso8601 format" do
        Timecop.freeze(given_time) do
          expect(authenticator.current_timestamp).to eq '2014-02-22T12:00:00Z'
        end
      end
    end

    describe "#request_signature" do
      it "hands a concatenated string encompassing the secret, request method, uri, and date to the digest service" do
        Timecop.freeze(given_time) do
          the_beast = "#{authenticator.api_secret}:GET:/accounts:#{authenticator.current_timestamp}"
          expect(Digest::SHA512).to receive(:hexdigest).with(the_beast)
          authenticator.request_signature('get', '/accounts')
        end
      end

      it "returns a SHA512 hash value" do
        Timecop.freeze(given_time) do
          expect(authenticator.request_signature("get", "/accounts")).to eq(
            Digest::SHA512.hexdigest "#{api_secret}:GET:/accounts:#{given_time.utc.iso8601}"
          )
        end
      end
    end

    describe "#secure_headers" do
      it "returns a hash with the required headers in" do
        required_headers = %w( x-armorpayments-apikey x-armorpayments-requesttimestamp x-armorpayments-signature )
        expect(authenticator.secure_headers('get', '/accounts').keys.sort).to eq required_headers.sort
      end

      it "assigns the correct value for each of the headers" do
        Timecop.freeze(given_time) do
          expect(authenticator.secure_headers('get', '/accounts')).to eq({
            "x-armorpayments-apikey"            => api_key,
            "x-armorpayments-signature"         => Digest::SHA512.hexdigest("#{api_secret}:GET:/accounts:#{given_time.utc.iso8601}"),
            "x-armorpayments-requesttimestamp"  => given_time.utc.iso8601
          })
        end
      end
    end

  end
end