module ArmorPayments
  class Offers
    attr_accessor :host, :authenticator, :uri_root

    def initialize host, authenticator, uri_root
      self.host           = host
      self.authenticator  = authenticator
      self.uri_root       = uri_root
    end

    def connection
      @connection ||= Excon.new(host, headers: { 'Accept' => 'application/json' })
    end

    def uri offer_id = nil
      template = "#{uri_root}/offers"
      template += "/#{offer_id}" if offer_id
      template
    end

    def all
      headers = authenticator.secure_headers 'get', uri
      connection.get(path: uri, headers: headers)
    end

    def get offer_id
      headers = authenticator.secure_headers 'get', uri(offer_id)
      connection.get(path: uri, headers: headers)
    end

    def update offer_id, data
      headers = authenticator.secure_headers 'post', uri(offer_id)
      connection.post(path: uri, headers: headers, body: JSON.generate(data))
    end

    def documents offer_id
      ArmorPayments::Documents.new(host, authenticator, uri(offer_id))
    end

    def notes offer_id
      ArmorPayments::Notes.new(host, authenticator, uri(offer_id))
    end

  end
end
