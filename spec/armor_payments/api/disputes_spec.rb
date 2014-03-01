require 'spec_helper'

module ArmorPayments
  describe Disputes do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:disputes) { Disputes.new(host, authenticator, '/accounts/1234/orders/56') }

    describe "#uri" do
      it "returns '/accounts/:aid/orders/:oid/disputes' if given no id" do
        disputes.uri.should == '/accounts/1234/orders/56/disputes'
      end

      it "returns '/accounts/:aid/disputes/:dispute_id' if given an id" do
        disputes.uri(78).should == '/accounts/1234/orders/56/disputes/78'
      end
    end

  end
end