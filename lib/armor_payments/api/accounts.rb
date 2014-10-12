module ArmorPayments
  class Accounts < Resource

    def create data
      headers = authenticator.secure_headers 'post', uri
      request :post, { path: uri, headers: headers, body: JSON.generate(data) }
    end
    
    def update account_id, data
      headers = authenticator.secure_headers 'post', uri(account_id)
      request :post, { path: uri(account_id), headers: headers, body: JSON.generate(data) }
    end

    def bankaccounts account_id
      ArmorPayments::BankAccounts.new(host, authenticator, uri(account_id))
    end

  end
end
