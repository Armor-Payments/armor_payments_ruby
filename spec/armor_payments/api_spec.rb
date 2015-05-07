require 'spec_helper'

module ArmorPayments
  describe API do
    let(:client) { ArmorPayments::API.new('my-key', 'my-secret', true) }

    describe "#armor_host" do
      context "in sandbox mode" do
        it "returns https://sandbox.armorpayments.com" do
          expect(client.sandbox).to be true
          expect(client.armor_host).to eq "https://sandbox.armorpayments.com"
        end
      end

      context "*not* in sandbox mode" do
        it "returns https://api.armorpayments.com" do
          client.sandbox = false
          expect(client.armor_host).to eq "https://api.armorpayments.com"
        end
      end
    end

  end
end