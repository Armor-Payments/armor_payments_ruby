module ArmorPayments
  class Documents
    attr_accessor :host, :authenticator, :uri_root

    def initialize host, authenticator, uri_root
      self.host           = host
      self.authenticator  = authenticator
      self.uri_root       = uri_root
    end

    def connection
      @connection ||= Excon.new(host, headers: { 'Accept' => 'application/json' })
    end

    def uri document_id = nil
      template = "#{uri_root.dup}/documents"
      template += "/#{document_id}" if document_id
      template
    end

    def all
      headers = authenticator.secure_headers 'get', uri
      connection.get(path: uri, headers: headers)
    end

    def get document_id
      headers = authenticator.secure_headers 'get', uri(document_id)
      connection.get(path: uri, headers: headers)
    end

    def create data
      headers = authenticator.secure_headers 'post', uri
      connection.post(path: uri, headers: headers, body: JSON.generate(data))
    end

  end
end
