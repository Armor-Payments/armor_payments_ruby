module ArmorPayments
  class Partner < Resource

    # Attempting to chain from the Accounts resource returned here will work
    # with .all(). Attempting to chain with other methods (for example, with
    # .get(account_id)) will result in a 404.
    def accounts partner_id
      ArmorPayments::Accounts.new(host, authenticator, uri(partner_id))
    end

    # Attempting to chain from the Users resource returned here will work
    # with .all(). Attempting to chain with other methods (for example, with
    # .get(user_id)) will result in a 404.
    def users partner_id
      ArmorPayments::Users.new(host, authenticator, uri(partner_id))
    end

  end
end
