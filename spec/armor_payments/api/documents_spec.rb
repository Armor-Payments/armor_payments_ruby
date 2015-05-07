require 'spec_helper'

module ArmorPayments
  describe Documents do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:documents) { Documents.new(host, authenticator, '/accounts/123/orders/456') }

    describe "#create" do

      it "makes POST with the right uri and JSONified data" do
        expect(documents).to receive(:request).with( :post, hash_including(path: '/accounts/123/orders/456/documents', body: '{"name":"Bobby Lee"}'))
        documents.create({ 'name' => 'Bobby Lee'})
      end

    end

  end
end