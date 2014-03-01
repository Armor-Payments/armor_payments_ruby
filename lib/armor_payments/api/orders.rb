module ArmorPayments
  class Orders < Resource

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

  end
end
