module ArmorPayments
  class Accounts
    attr_accessor :host, :authenticator

    ROOT = "/accounts"

    def initialize host, authenticator
      self.host           = host
      self.authenticator  = authenticator
    end

    def connection
      @connection ||= Excon.new(host, headers: { 'Accept' => 'application/json' })
    end

    def uri account_id = nil
      base = ROOT.dup
      base += "/#{account_id}" if account_id
      base
    end

    def all
      headers = authenticator.secure_headers 'get', uri
      connection.get(path: uri, headers: headers)
    end

    def get account_id
      headers = authenticator.secure_headers 'get', uri(account_id)
      connection.get(path: uri, headers: headers)
    end

    def create data
      headers = authenticator.secure_headers 'post', uri
      connection.post(path: uri, headers: headers, body: JSON.generate(data))
    end
  end
end

__END__
api.accounts.all() # return all accounts
api.accounts.get(account_id) # return account ID 1
api.accounts.create(data) # create a new account