require 'spec_helper'

module ArmorPayments
  describe Accounts do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:accounts) { Accounts.new(host, authenticator) }

    describe "#uri" do
      it "returns '/accounts' if given no id" do
        accounts.uri.should == '/accounts'
      end

      it "returns '/accounts/:id' if given an id" do
        accounts.uri(456).should == '/accounts/456'
      end
    end

    context "smoketest" do
      describe "#all" do
        it "queries the host for all accounts, with approprate headers" do
          Timecop.freeze(2014, 2, 22, 12, 0, 0) do
            accounts.connection.should_receive(:get).with({
              path: '/accounts',
              headers: {
                "X_ARMORPAYMENTS_APIKEY"            => "my-api-key",
                "X_ARMORPAYMENTS_REQUESTTIMESTAMP"  => "2014-02-22T17:00:00Z",
                "X_ARMORPAYMENTS_SIGNATURE"         => "777990373678937074c1b357d632e0ea3439d0e834e573c03076ee557f526565f9ac2b38483b3e41024b96ec2644d60b4f70f0d9c760b2ebeb9827f9b335d069"
              }
            })

            accounts.all
          end
        end
      end

    end

  end
end