# ArmorPayments

This is intended to be a clean, idiomatic client for the [Armor Payments API](http://armorpayments.com/api/index.html). This will handle generating the authenticated headers and constructing the properly nested request URI, as well as parsing any response JSON for you.

## Installation

Add this line to your application's Gemfile:

    gem 'armor_payments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install armor_payments

## Usage

The Armor Payments API is REST-ish and nested, so the client relies on chaining. We return an `Excon::Response` object, with the added nice-ness that we've parsed the JSON response body for you if possible.

```ruby
require 'armor_payments'

client = ArmorPayments::API.new 'your-key', 'your-secret', should_use_sandbox

# There are three top-level resources: accounts, partner, and shipmentcarriers

client.accounts.all
client.accounts.get(account_id)

client.partner.get(partner_id)

client.shipmentcarriers.all
client.shipmentcarriers.get(carrier_id)

# For convenience, orders and users can be called as top-level resources,
# but they can also be chained from accounts
client.users(account_id).all
client.users(account_id).get(user_id)

client.orders(account_id).all
client.orders(account_id).get(order_id)

# From accounts, we chain bank accounts, orders, and users

client.accounts.bankaccounts(account_id).all
client.accounts.bankaccounts(account_id).get(bank_account_id)

client.accounts.orders(account_id).all
client.accounts.orders(account_id).get(order_id)

client.accounts.users(account_id).all
client.accounts.users(account_id).get(user_id)

# From orders, many things chain: documents, notes, disputes, shipments, payment instructions, order events

client.orders(account_id).documents(order_id).all
client.orders(account_id).documents(order_id).get(document_id)

client.orders(account_id).notes(order_id).all
client.orders(account_id).notes(order_id).get(note_id)

client.orders(account_id).disputes(order_id).all
client.orders(account_id).disputes(order_id).get(dispute_id)

client.orders(account_id).shipments(order_id).all
client.orders(account_id).shipments(order_id).get(shipment_id)

client.orders(account_id).paymentinstructions(order_id).all

client.orders(account_id).orderevents(order_id).all
client.orders(account_id).orderevents(order_id).get(event_id)

# From disputes, further things chain: documents, notes, offers

client.orders(account_id).disputes(order_id).documents(dispute_id).all
client.orders(account_id).disputes(order_id).documents(dispute_id).get(document_id)

client.orders(account_id).disputes(order_id).notes(dispute_id).all
client.orders(account_id).disputes(order_id).notes(dispute_id).get(note_id)

client.orders(account_id).disputes(order_id).offers(dispute_id).all
client.orders(account_id).disputes(order_id).offers(dispute_id).get(offer_id)

# From offers, documents and notes chain

client.orders(account_id).disputes(order_id).offers(dispute_id).
  documents(offer_id).all
client.orders(account_id).disputes(order_id).offers(dispute_id).
  documents(offer_id).get(document_id)

client.orders(account_id).disputes(order_id).offers(dispute_id).
  notes(offer_id).all
client.orders(account_id).disputes(order_id).offers(dispute_id).
  notes(offer_id).get(note_id)

# From partner, you can chain the accounts and users associated with your partner account
partner.accounts(partner_id).all()
partner.users(partner_id).all()
```

Some of the resource endpoints support Create/Update `POST` operations, and this client aims to support those as well:

```ruby
client.accounts.create(your_data)
client.accounts.update(account_id, your_data)

client.accounts.bankaccounts(account_id).create(your_data)

client.accounts.users(account_id).create(your_data)

client.accounts.users(account_id).authentications(user_id).create(your_data)

client.orders(account_id).create(your_data)

client.orders(account_id).shipments(order_id).create(your_data)

client.{object-path}.documents.create(your_data)

client.{object-path}.notes.create(your_data)

client.{object-path}.orders.update(order_id, your_data)

client.{object-path}.offers.update(offer_id, your_data)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
