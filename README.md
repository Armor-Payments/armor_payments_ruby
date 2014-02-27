# ArmorPayments

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'armor_payments'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install armor_payments

## Usage

TODO: Write usage instructions here

```ruby
require 'armor_payments'

client = ArmorPayments::API.new 'your-key', 'your-secret', should_use_sandbox

# There are three top-level resources: accounts, users, and orders
# Querying users and orders requires an account_id

client.accounts.all
client.accounts.get(account_id)

client.users(account_id).all
client.users(account_id).get(user_id)

client.orders(account_id).all
client.orders(account_id).get(order_id)

# From orders, many things chain: documents, notes, disputes

client.orders(account_id).documents(order_id).all
client.orders(account_id).documents(order_id).get(document_id)
client.orders(account_id).notes(order_id).all
client.orders(account_id).notes(order_id).get(note_id)
client.orders(account_id).disputes(order_id).all
client.orders(account_id).disputes(order_id).get(dispute_id)

# From disputes, further things chain: documents, notes, offers

client.orders(account_id).disputes(order_id).documents(order_id).all
client.orders(account_id).disputes(order_id).documents(order_id).get(document_id)
client.orders(account_id).disputes(order_id).notes(order_id).all
client.orders(account_id).disputes(order_id).notes(order_id).get(note_id)
client.orders(account_id).disputes(order_id).offers(dispute_id).all
client.orders(account_id).disputes(order_id).offers(dispute_id).get(offer_id)

# From offers, documents and notes chain

client.orders(account_id).disputes(order_id).offers(dispute_id).documents(order_id).all
client.orders(account_id).disputes(order_id).offers(dispute_id).documents(order_id).get(document_id)
client.orders(account_id).disputes(order_id).offers(dispute_id).notes(order_id).all
client.orders(account_id).disputes(order_id).offers(dispute_id).notes(order_id).get(note_id)


```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
