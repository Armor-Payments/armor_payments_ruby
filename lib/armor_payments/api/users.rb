module ArmorPayments
  class Users < Resource

    def create data
      headers = authenticator.secure_headers 'post', uri
      request :post, { path: uri, headers: headers, body: JSON.generate(data) }
    end
    
    def update user_id, data
      headers = authenticator.secure_headers 'post', uri(user_id)
      request :post, { path: uri(user_id), headers: headers, body: JSON.generate(data) }
    end

    def authentications user_id
      ArmorPayments::Authentications.new(host, authenticator, uri(user_id))
    end

  end
end
