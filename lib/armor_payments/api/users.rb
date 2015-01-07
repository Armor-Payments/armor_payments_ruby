module ArmorPayments
  class Users < Resource

    def update user_id, data
      headers = authenticator.secure_headers 'post', uri(user_id)
      request :post, { path: uri(user_id), headers: headers, body: JSON.generate(data) }
    end

  end
end
