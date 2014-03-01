require 'spec_helper'

module ArmorPayments
  describe Offers do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:offers) { Offers.new(host, authenticator, '/accounts/1234') }

    describe "#update" do
      it "makes POST with the right uri and JSONified data" do
        offers.should_receive(:request).with(
          :post,
          hash_including(path: '/accounts/1234/offers/90', body: '{"name":"Bobby Lee"}')
        )
        offers.update(90, { 'name' => 'Bobby Lee'})
      end
    end

  end
end