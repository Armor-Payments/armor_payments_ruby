require 'spec_helper'

module ArmorPayments
  describe OrderLedgers do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:orderledgers) { OrderLedgers.new(host, authenticator, '/accounts/1234/orders/2345') }

    describe "#uri" do
      it "returns '/accounts/:aid/orders/:oid/orderledgers' if given no id" do
        expect(orderledgers.uri).to eq '/accounts/1234/orders/2345/orderledgers'
      end

      it "returns '/accounts/:aid/orders/:oid/orderledgers/:ledger_id' if given an id" do
        expect(orderledgers.uri(3456)).to eq '/accounts/1234/orders/2345/orderledgers/3456'
      end
    end
  end
end