require 'excon'
require 'json'
require 'armor_payments/authenticator'
require 'armor_payments/api/resource'
require 'armor_payments/api/accounts'
require 'armor_payments/api/orders'
require 'armor_payments/api/documents'
require 'armor_payments/api/notes'
require 'armor_payments/api/disputes'
require 'armor_payments/api/offers'
require 'armor_payments/api/users'
require 'armor_payments/api/paymentinstructions'
require 'armor_payments/api/shipments'

module ArmorPayments
  class API

    attr_accessor :authenticator, :sandbox

    def initialize api_key, api_secret, sandbox = false
      self.authenticator = ArmorPayments::Authenticator.new(api_key, api_secret)
      self.sandbox = sandbox
    end

    def armor_host
      "https://#{sandbox ? 'sandbox' : 'api'}.armorpayments.com"
    end

    def accounts
      @accounts ||= ArmorPayments::Accounts.new(armor_host, authenticator, '')
    end

    def orders account_id
      ArmorPayments::Orders.new(armor_host, authenticator, accounts.uri(account_id))
    end

    def users account_id
      ArmorPayments::Users.new(armor_host, authenticator, accounts.uri(account_id))
    end

  end
end
