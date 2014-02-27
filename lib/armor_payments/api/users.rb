module ArmorPayments
  class Users
    attr_accessor :host, :authenticator, :account_id

    def initialize host, authenticator, account_id
      self.host           = host
      self.authenticator  = authenticator
      self.account_id     = account_id
    end

    def connection
      @connection ||= Excon.new(host, headers: { 'Accept' => 'application/json' })
    end

    def uri user_id = nil
      template = '/accounts/%{account_id}/users'
      template += '/%{user_id}' if user_id
      params = { account_id: account_id, user_id: user_id }.inject({}) do |hsh, (key, value)|
        hsh.merge!( key => value) unless value.nil?
        hsh
      end
      template % params
    end

    def all
      headers = authenticator.secure_headers 'get', uri
      connection.get(path: uri, headers: headers)
    end

    def get user_id
      headers = authenticator.secure_headers 'get', uri(user_id)
      connection.get(path: uri, headers: headers)
    end

  end
end
