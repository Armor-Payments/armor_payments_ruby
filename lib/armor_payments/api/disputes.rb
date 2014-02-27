module ArmorPayments
  class Disputes
    attr_accessor :host, :authenticator, :uri_root

    def initialize host, authenticator, uri_root
      self.host           = host
      self.authenticator  = authenticator
      self.uri_root       = uri_root
    end

    def connection
      @connection ||= Excon.new(host, headers: { 'Accept' => 'application/json' })
    end

    def uri dispute_id = nil
      template = "#{uri_root}/disputes"
      template += "/#{dispute_id}" if dispute_id
      template
    end

    def all
      headers = authenticator.secure_headers 'get', uri
      connection.get(path: uri, headers: headers)
    end

    def get dispute_id
      headers = authenticator.secure_headers 'get', uri(dispute_id)
      connection.get(path: uri, headers: headers)
    end

    def documents dispute_id
      ArmorPayments::Documents.new(host, authenticator, uri(dispute_id))
    end

    def notes dispute_id
      ArmorPayments::Notes.new(host, authenticator, uri(dispute_id))
    end

    def offers dispute_id
      ArmorPayments::Offers.new(host, authenticator, uri(dispute_id))
    end
  end
end
