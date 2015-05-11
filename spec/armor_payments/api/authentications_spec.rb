require 'spec_helper'

module ArmorPayments
  describe Authentications do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:authentications) { Authentications.new(host, authenticator, '/accounts/1234/users/2345') }

    describe "#uri" do
      it "returns '/accounts/:aid/users/:uid/authentications' if given no id" do
        expect(authentications.uri).to eq '/accounts/1234/users/2345/authentications'
      end

      it "returns '/accounts/:aid/users/:uid/authentications/:auth_id' if given an id" do
        expect(authentications.uri(3456)).to eq '/accounts/1234/users/2345/authentications/3456'
      end
    end

    describe "#create" do
      it "makes POST with the right uri and JSONified data" do
        expect(authentications).to receive(:request).with( :post, hash_including(path: '/accounts/1234/users/2345/authentications', body: '{"uri":"/accounts/1234/orders/5678"}'))
        authentications.create({ 'uri' => '/accounts/1234/orders/5678'})
      end
    end
  end
end