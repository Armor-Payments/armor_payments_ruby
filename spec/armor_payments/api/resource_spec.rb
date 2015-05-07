require 'spec_helper'

module ArmorPayments
  describe Resource do
    let(:api_key) { 'my-api-key' }
    let(:api_secret) { 'my-secret-code' }
    let(:authenticator) { Authenticator.new(api_key, api_secret) }
    let(:host) { 'https://sandbox.armorpayments.com' }
    let(:uri_root) { '/wibble/123' }
    let(:resource) { Resource.new(host, authenticator, uri_root) }
    let(:successful_response) { Excon::Response.new(status: 200, body: '{"whee":42}', headers: { 'Content-Type' => 'application/json' }) }

    describe "#uri" do
      it "returns '/%{uri_root}/resource_name' if given no id" do
        expect(resource.uri).to eq '/wibble/123/resource'
      end

      it "returns '/%{uri_root}/resource_name/:id' if given an id" do
        expect(resource.uri(456)).to eq '/wibble/123/resource/456'
      end
    end

    describe "#request" do
      context "on a response with a JSON body" do
        it "returns the parsed JSON body" do
          allow(resource.connection).to receive(:get).and_return(successful_response)
          response = resource.request('get', {})
          expect(response.body).to eq 'whee' => 42
        end
      end

      context "on a response without JSON" do
        it "returns the full response object" do
          failed_response = Excon::Response.new(status: 502, body: 'Gateway Timeout')
          allow(resource.connection).to receive(:get).and_return(failed_response)
          response = resource.request('get', {})
          expect(response.body).to eq 'Gateway Timeout'
        end
      end
    end

    context "smoketest" do
      let(:given_time) { Time.new(2014, 2, 22, 12, 0, 0, "+00:00") }

      describe "#all" do
        it "queries the host for all of the resources, with approprate headers" do
          Timecop.freeze(given_time) do
            expect(resource.connection).to receive(:get).with({
              path: '/wibble/123/resource',
              headers: {
                "x-armorpayments-apikey"            => "my-api-key",
                "x-armorpayments-requesttimestamp"  => "2014-02-22T12:00:00Z",
                "x-armorpayments-signature"         => Digest::SHA512.hexdigest("#{api_secret}:GET:/wibble/123/resource:#{given_time.utc.iso8601}")
              }
            }).and_return(successful_response)

            resource.all
          end
        end
      end

      describe "#get" do
        it "queries the host for a specific resource, with approprate headers" do
          Timecop.freeze(given_time) do
            expect(resource.connection).to receive(:get).with({
              path: '/wibble/123/resource/456',
              headers: {
                "x-armorpayments-apikey"            => "my-api-key",
                "x-armorpayments-requesttimestamp"  => "2014-02-22T12:00:00Z",
                "x-armorpayments-signature"         => Digest::SHA512.hexdigest("#{api_secret}:GET:/wibble/123/resource/456:#{given_time.utc.iso8601}")
              }
            }).and_return(successful_response)

            resource.get(456)
          end
        end
      end

    end

  end
end