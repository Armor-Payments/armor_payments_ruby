require 'spec_helper'

module ArmorPayments
  describe Partner do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:partner) { Partner.new(host, authenticator, '') }

    describe "#uri" do
      it "returns '/partner' if given no id" do
        expect(accounts.uri).to eq '/partner'
      end

      it "returns '/partner/:id' if given an id" do
        expect(partner.uri(456)).to eq '/partner/456'
      end
    end

  end
end