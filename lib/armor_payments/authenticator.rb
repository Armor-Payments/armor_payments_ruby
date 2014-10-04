require 'digest/sha2'

module ArmorPayments
  class Authenticator

    attr_accessor :api_key, :api_secret

    def initialize key, secret
      self.api_key = key
      self.api_secret = secret
    end

    def secure_headers method, uri
      {
        'x-armorpayments-apikey'           => api_key,
        'x-armorpayments-requesttimestamp' => current_timestamp,
        'x-armorpayments-signature'        => request_signature(method, uri)
      }
    end

    def current_timestamp
      Time.now.utc.iso8601
    end

    def request_signature method, uri
      Digest::SHA512.hexdigest "#{api_secret}:#{method.to_s.upcase}:#{uri}:#{current_timestamp}"
    end

  end
end
