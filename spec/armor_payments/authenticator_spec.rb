require 'spec_helper'
require 'armor_payments/authenticator'

module ArmorPayments
  describe Authenticator do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:time) { Time.new(2014, 2, 22, 12, 0, 0, "+00:00") }

    describe "#current_timestamp" do
      it "returns the current time in iso8601 format" do
        Timecop.freeze(time) do
          expect(authenticator.current_timestamp).to eq '2014-02-22T12:00:00Z'
        end
      end
    end

    describe "#request_signature" do
      it "hands a concatenated string encompassing the secret, request method, uri, and date to the digest service" do
        Timecop.freeze(time) do
          the_beast = "#{authenticator.api_secret}:GET:/accounts:#{authenticator.current_timestamp}"
          expect(Digest::SHA512).to receive(:hexdigest).with(the_beast)
          authenticator.request_signature('get', '/accounts')
        end
      end

      it "returns a SHA512 hash value" do
        Timecop.freeze(time) do
          expect(authenticator.request_signature("get", "/accounts")).to eq(
            "777990373678937074c1b357d632e0ea3439d0e834e573c03076ee557f526565f9ac2b38483b3e41024b96ec2644d60b4f70f0d9c760b2ebeb9827f9b335d069"
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
        Timecop.freeze(time) do
          expect(authenticator.secure_headers('get', '/accounts')).to eq({
            "x-armorpayments-apikey"            => "my-api-key",
            "x-armorpayments-signature"         => "777990373678937074c1b357d632e0ea3439d0e834e573c03076ee557f526565f9ac2b38483b3e41024b96ec2644d60b4f70f0d9c760b2ebeb9827f9b335d069",
            "x-armorpayments-requesttimestamp"  => "2014-02-22T12:00:00Z"
          })
        end
      end
    end

  end
end