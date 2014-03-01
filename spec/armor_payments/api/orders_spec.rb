require 'spec_helper'

module ArmorPayments
  describe Orders do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:orders) { Orders.new(host, authenticator, '/accounts/1234') }

    describe "#uri" do
      it "returns '/accounts/:aid/orders' if given no id" do
        orders.uri.should == '/accounts/1234/orders'
      end

      it "returns '/accounts/:aid/orders/:order_id' if given an id" do
        orders.uri(456).should == '/accounts/1234/orders/456'
      end
    end

    describe "#update" do
      it "makes POST with the right uri and JSONified data" do
        orders.should_receive(:request).with(
          :post,
          hash_including(path: '/accounts/1234/orders/90', body: '{"name":"Bobby Lee"}')
        )
        orders.update(90, { 'name' => 'Bobby Lee'})
      end
    end

  end
end