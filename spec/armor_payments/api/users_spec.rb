require 'spec_helper'

module ArmorPayments
  describe Users do
    let(:authenticator) { Authenticator.new('my-api-key', 'my-secret-code') }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:users) { Users.new(host, authenticator, 1234) }

    describe "#uri" do
      it "returns '/users' if given no id" do
        users.uri.should == '/accounts/1234/users'
      end

      it "returns '/users/:id' if given an id" do
        users.uri(456).should == '/accounts/1234/users/456'
      end
    end

    context "smoketest" do
      describe "#all" do
        it "queries the host for all users, with approprate headers" do
          Timecop.freeze(2014, 2, 22, 12, 0, 0) do
            users.connection.should_receive(:get).with({
              path: '/accounts/1234/users',
              headers: {
                "X_ARMORPAYMENTS_APIKEY"           => "my-api-key",
                "X_ARMORPAYMENTS_REQUESTTIMESTAMP" => "2014-02-22T17:00:00Z",
                "X_ARMORPAYMENTS_SIGNATURE"        => "267d6fa050ac47ddc61962b5756873c7c01d22c301119b3668c3cdf4c5dfc7c28c7b4fc4a122c77e930ff72aca4a8267e1a656f891cceb5af4238f2fc1115cdd"
              }
            })

            users.all
          end
        end
      end

    end

  end
end