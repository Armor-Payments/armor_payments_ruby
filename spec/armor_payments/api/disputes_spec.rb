require 'spec_helper'

module ArmorPayments
  describe Disputes do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:disputes) { Disputes.new(host, authenticator, '/accounts/1234/orders/56') }

    describe "#uri" do
      it "returns '/accounts/:aid/orders/:oid/disputes' if given no id" do
        expect(disputes.uri).to eq '/accounts/1234/orders/56/disputes'
      end

      it "returns '/accounts/:aid/disputes/:dispute_id' if given an id" do
        expect(disputes.uri(78)).to eq '/accounts/1234/orders/56/disputes/78'
      end
    end

  end
end