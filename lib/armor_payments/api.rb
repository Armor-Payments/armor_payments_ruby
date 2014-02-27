require 'excon'
require 'json'
require 'armor_payments/authenticator'
require 'armor_payments/api/accounts'
require 'armor_payments/api/orders'

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
      @accounts ||= ArmorPayments::Accounts.new(armor_host, authenticator)
    end

    def orders account_id
      ArmorPayments::Orders.new(armor_host, authenticator, account_id)
    end

  end
end

__END__

api.disputes.get(account_id, order_id, dispute_id)
api.disputes.get_documents(account_id, order_id, dispute_id)
api.disputes.get_document(account_id, order_id, dispute_id, document_id)
api.disputes.get_note(account_id, order_id, dispute_id, note_id)

api.offers.get(account_id, offer_id)
api.offers.update(account_id, offer_id, data)
api.offers.get_documents(account_id, offer_id)
api.offers.get_document(account_id, offer_id, document_id)
api.offers.get_note(account_id, offer_id, note_id)

api.orders.all(account_id)
api.orders.get(account_id, order_id)
api.orders.create(account_id, data)
api.orders.get_documents(account_id, order_id)
api.orders.get_document(account_id, order_id, document_id)
api.orders.get_notes(account_id, order_id)
api.orders.get_note(account_id, order_id, note_id)

api.users.all(account_id)
api.users.get(account_id, user_id)