module ArmorPayments
  class Resource
    attr_accessor :host, :authenticator, :uri_root

    def initialize host, authenticator, uri_root
      self.host           = host
      self.authenticator  = authenticator
      self.uri_root       = uri_root
    end

    def connection
      @connection ||= Excon.new(host, headers: { 'Accept' => 'application/json' })
    end

    def resource_name
      self.class.to_s.downcase.split('::').last
    end

    def uri object_id = nil
      base = "#{uri_root}/#{resource_name}"
      base += "/#{object_id}" if object_id
      base
    end

    # On a successful request, return the JSON
    # On an unsuccessful request, return the response object for further interrogation
    def request method, params
      response = connection.send(method, params)
      if response.get_header('Content-Type') =~ /json/i
        response.body = JSON.parse response.body
      end
      response
    end

    def all
      headers = authenticator.secure_headers 'get', uri
      request :get, { path: uri, headers: headers }
    end

    def get object_id
      headers = authenticator.secure_headers 'get', uri(object_id)
      request :get, { path: uri(object_id), headers: headers }
    end
  end
end
