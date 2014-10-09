module ArmorPayments
  class Orders < Resource

    def create data
      headers = authenticator.secure_headers 'post', uri
      request :post, { path: uri, headers: headers, body: JSON.generate(data) }
    end
    
    def update order_id, data
      headers = authenticator.secure_headers 'post', uri(order_id)
      request :post, { path: uri(order_id), headers: headers, body: JSON.generate(data) }
    end

    def documents order_id
      ArmorPayments::Documents.new(host, authenticator, uri(order_id))
    end

    def notes order_id
      ArmorPayments::Notes.new(host, authenticator, uri(order_id))
    end

    def disputes order_id
      ArmorPayments::Disputes.new(host, authenticator, uri(order_id))
    end

    def orderevents order_id
      ArmorPayments::OrderEvents.new(host, authenticator, uri(order_id))
    end

    def paymentinstructions order_id
      ArmorPayments::PaymentInstructions.new(host, authenticator, uri(order_id))
    end

    def shipments order_id
      ArmorPayments::Shipments.new(host, authenticator, uri(order_id))
    end

  end
end
