require 'spec_helper'
require 'armor_payments/authenticator'

module ArmorPayments
  describe Authenticator do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }

    describe "#current_timestamp" do
      it "returns the current time in iso8601 format" do
        Timecop.freeze(2014, 2, 22, 12, 0, 0) do
          authenticator.current_timestamp.should == '2014-02-22T17:00:00Z'
        end
      end
    end

    describe "#request_signature" do
      it "hands a concatenated string encompassing the secret, request method, uri, and date to the digest service" do
        Timecop.freeze(2014, 2, 22, 12, 0, 0) do
          the_beast = "#{authenticator.api_secret}:GET:/accounts:#{authenticator.current_timestamp}"
          Digest::SHA512.should_receive(:hexdigest).with(the_beast)
          authenticator.request_signature('get', '/accounts')
        end
      end

      it "returns a SHA512 hash value" do
        Timecop.freeze(2014, 2, 22, 12, 0, 0) do
          authenticator.request_signature("get", "/accounts").should ==
            "777990373678937074c1b357d632e0ea3439d0e834e573c03076ee557f526565f9ac2b38483b3e41024b96ec2644d60b4f70f0d9c760b2ebeb9827f9b335d069"
        end
      end
    end

    describe "#secure_headers" do
      it "returns a hash with the required headers in" do
        required_headers = %w( X_ARMORPAYMENTS_APIKEY X_ARMORPAYMENTS_TIMESTAMP X_ARMORPAYMENTS_SIGNATURE )
        authenticator.secure_headers('get', '/accounts').keys.sort.should == required_headers.sort
      end

      it "assigns the correct value for each of the headers" do
        Timecop.freeze(2014, 2, 22, 12, 0, 0) do
          authenticator.secure_headers('get', '/accounts').should == {
            "X_ARMORPAYMENTS_APIKEY"    => "my-api-key",
            "X_ARMORPAYMENTS_SIGNATURE" => "777990373678937074c1b357d632e0ea3439d0e834e573c03076ee557f526565f9ac2b38483b3e41024b96ec2644d60b4f70f0d9c760b2ebeb9827f9b335d069",
            "X_ARMORPAYMENTS_TIMESTAMP" => "2014-02-22T17:00:00Z"
          }
        end
      end
    end

  end
end