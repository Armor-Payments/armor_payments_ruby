module ArmorPayments
  class Users < Resource

    def update account_id, data
      headers = authenticator.secure_headers 'post', uri(account_id)
      request :post, { path: uri(account_id), headers: headers, body: JSON.generate(data) }
    end

  end
end
