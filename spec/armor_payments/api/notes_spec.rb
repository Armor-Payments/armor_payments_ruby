require 'spec_helper'

module ArmorPayments
  describe Notes do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:notes) { Notes.new(host, authenticator, '/accounts/123/orders/456') }

    describe "#create" do

      it "makes POST with the right uri and JSONified data" do
        expect(notes).to receive(:request).with( :post, hash_including(path: '/accounts/123/orders/456/notes', body: '{"name":"Bobby Lee"}'))
        notes.create({ 'name' => 'Bobby Lee'})
      end

    end

  end
end