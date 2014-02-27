require 'spec_helper'

module ArmorPayments
  describe Orders do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:orders) { Orders.new(host, authenticator, 1234) }

    describe "#uri" do
      it "returns '/accounts/:aid/orders' if given no id" do
        orders.uri.should == '/accounts/1234/orders'
      end

      it "returns '/accounts/:aid/orders/:order_id' if given an id" do
        orders.uri(456).should == '/accounts/1234/orders/456'
      end

      it "returns '/accounts/:aid/orders/:order_id/documents/:document_id if given two params" do
        orders.uri(456, 789).should == '/accounts/1234/orders/456/documents/789'
      end

      it "returns '/accounts/:aid/orders/:order_id/notes/:note_id if given three params" do
        orders.uri(456, nil, 789).should == '/accounts/1234/orders/456/notes/789'
      end
    end

    context "smoketest" do
      describe "#all" do
        it "queries the host for all accounts, with approprate headers" do
          Timecop.freeze(2014, 2, 22, 12, 0, 0) do
            orders.connection.should_receive(:get).with({
              path: '/accounts/1234/orders',
              headers: {
                "X_ARMORPAYMENTS_APIKEY"    => "my-api-key",
                "X_ARMORPAYMENTS_TIMESTAMP" => "2014-02-22T17:00:00Z",
                "X_ARMORPAYMENTS_SIGNATURE" => "fcb76e9a5ea322594ba4d636bd9653deb7cf9d9632cf67a146e4525d4055180d7e81f9d099f056aa884646ecb83f5e313cc216a21d64004b147e611e3f10257b"
              }
            })

            orders.all
          end
        end
      end

    end

  end
end