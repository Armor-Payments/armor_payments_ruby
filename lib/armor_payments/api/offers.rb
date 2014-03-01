module ArmorPayments
  class Offers < Resource

    def update offer_id, data
      headers = authenticator.secure_headers 'post', uri(offer_id)
      request :post, { path: uri(offer_id), headers: headers, body: JSON.generate(data) }
    end

    def documents offer_id
      ArmorPayments::Documents.new(host, authenticator, uri(offer_id))
    end

    def notes offer_id
      ArmorPayments::Notes.new(host, authenticator, uri(offer_id))
    end

  end
end
