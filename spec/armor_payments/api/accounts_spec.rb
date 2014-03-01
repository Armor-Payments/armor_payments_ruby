require 'spec_helper'

module ArmorPayments
  describe Accounts do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:accounts) { Accounts.new(host, authenticator, '') }

    describe "#uri" do
      it "returns '/accounts' if given no id" do
        accounts.uri.should == '/accounts'
      end

      it "returns '/accounts/:id' if given an id" do
        accounts.uri(456).should == '/accounts/456'
      end
    end

    describe "#create" do

      it "makes POST with /accounts and JSONified data" do
        accounts.should_receive(:request).with( :post, hash_including(path: '/accounts', body: '{"name":"Bobby Lee"}'))
        accounts.create({ 'name' => 'Bobby Lee'})
      end

    end

  end
end