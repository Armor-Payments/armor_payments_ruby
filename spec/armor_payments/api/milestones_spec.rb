require 'spec_helper'

module ArmorPayments
  describe Milestones do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:milestones) { Milestones.new(host, authenticator, '/accounts/1234/orders/56') }

    describe "#uri" do
      it "returns '/accounts/:aid/orders/:oid/milestones' if given no id" do
        expect(milestones.uri).to eq '/accounts/1234/orders/56/milestones'
      end
    end

  end
end