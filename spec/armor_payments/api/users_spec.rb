require 'spec_helper'

module ArmorPayments
  describe Users do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:users) { Users.new(host, authenticator, '/accounts/1234') }

    describe "#uri" do
      it "returns '/users' if given no id" do
        users.uri.should == '/accounts/1234/users'
      end

      it "returns '/users/:id' if given an id" do
        users.uri(456).should == '/accounts/1234/users/456'
      end
    end

  end
end