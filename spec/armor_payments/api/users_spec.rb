require 'spec_helper'

module ArmorPayments
  describe Users do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:users) { Users.new(host, authenticator, '/accounts/1234') }

    describe "#uri" do
      it "returns 'accounts/:aid/users' if given no id" do
        expect(users.uri).to eq '/accounts/1234/users'
      end

      it "returns 'accounts/:aid/users/:id' if given an id" do
        expect(users.uri(456)).to eq '/accounts/1234/users/456'
      end
    end

    describe "#create" do

      it "makes POST with the appropriate URI and JSONified data" do
        expect(users).to receive(:request).with( :post, hash_including(path: '/accounts/1234/users', body: '{"name":"Bobby Lee"}'))
        users.create({ 'name' => 'Bobby Lee'})
      end

    end

  end
end