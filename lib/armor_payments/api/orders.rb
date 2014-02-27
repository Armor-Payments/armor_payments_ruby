module ArmorPayments
  class Orders
    attr_accessor :host, :authenticator, :account_id

    def initialize host, authenticator, account_id
      self.host           = host
      self.authenticator  = authenticator
      self.account_id     = account_id
    end

    def connection
      @connection ||= Excon.new(host, headers: { 'Accept' => 'application/json' })
    end

    def uri order_id = nil, document_id = nil, note_id = nil
      template = '/accounts/%{account_id}/orders'
      template += '/%{order_id}' if order_id
      template += '/documents/%{document_id}' if document_id
      template += '/notes/%{note_id}' if note_id
      params = { account_id: account_id, order_id: order_id, document_id: document_id, note_id: note_id }.inject({}) do |hsh, (key, value)|
        hsh.merge!( key => value) unless value.nil?
        hsh
      end
      template % params
    end

    def all
      headers = authenticator.secure_headers 'get', uri
      connection.get(path: uri, headers: headers)
    end

    def get order_id
      headers = authenticator.secure_headers 'get', uri(order_id)
      connection.get(path: uri, headers: headers)
    end

    def create data
      headers = authenticator.secure_headers 'post', uri
      connection.post(path: uri, headers: headers, body: JSON.generate(data))
    end
  end
end

__END__
api.orders.get_documents(account_id, order_id)
api.orders.get_document(account_id, order_id, document_id)
api.orders.get_notes(account_id, order_id)
api.orders.get_note(account_id, order_id, note_id)