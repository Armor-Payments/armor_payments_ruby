module ArmorPayments
  class Accounts < Resource

    def create data
      headers = authenticator.secure_headers 'post', uri
      request :post, { path: uri, headers: headers, body: JSON.generate(data) }
    end
    
    def update data
      headers = authenticator.secure_headers 'post', uri
      request :post, { path: uri, headers: headers, body: JSON.generate(data) }
    end

  end
end
