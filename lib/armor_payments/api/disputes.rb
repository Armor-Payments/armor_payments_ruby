module ArmorPayments
  class Disputes < Resource

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
