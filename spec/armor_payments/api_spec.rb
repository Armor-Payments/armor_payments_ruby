require 'spec_helper'

module ArmorPayments
  describe API do
    let(:client) { ArmorPayments::API.new('my-key', 'my-secret', true) }

    describe "#armor_host" do
      context "in sandbox mode" do
        it "returns https://sandbox.armorpayments.com" do
          client.sandbox.should be_true
          client.armor_host.should == "https://sandbox.armorpayments.com"
        end
      end

      context "*not* in sandbox mode" do
        it "returns https://api.armorpayments.com" do
          client.sandbox = false
          client.armor_host.should == "https://api.armorpayments.com"
        end
      end
    end

  end
end