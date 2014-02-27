module ArmorPayments
  class Orders
    attr_accessor :host, :authenticator, :uri_root

    def initialize host, authenticator, uri_root
      self.host           = host
      self.authenticator  = authenticator
      self.uri_root       = uri_root
    end

    def connection
      @connection ||= Excon.new(host, headers: { 'Accept' => 'application/json' })
    end

    def uri order_id = nil
      template = "#{uri_root}/orders"
      template += "/#{order_id}" if order_id
      template
    end

    def all
      headers = authenticator.secure_headers 'get', uri
      connection.get(path: uri, headers: headers)
    end

    def get order_id
      headers = authenticator.secure_headers 'get', uri(order_id)
      connection.get(path: uri, headers: headers)
    end

    def update order_id, data
      headers = authenticator.secure_headers 'post', uri(order_id)
      connection.post(path: uri, headers: headers, body: JSON.generate(data))
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