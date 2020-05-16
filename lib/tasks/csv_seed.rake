require 'CSV'
require './app/models/application_record.rb'
require './app/models/customer.rb'

desc "seeds DB with all csv files"
namespace :db do
  task seed_csv: :environment do
    customers_location = "./db/csv/customers.csv"
    invoice_items_location = "./db/csv/invoice_items.csv"
    invoices_location = "./db/csv/invoices.csv"
    items_location = "./db/csv/items.csv"
    merchants_location = "./db/csv/merchants.csv"
    transactions_location = "./db/csv/transactions.csv"

    csv_info =
    {
      Customer => customers_location,
      Merchant => merchants_location,
      Item => items_location,
      Invoice => invoices_location,
      InvoiceItem => invoice_items_location,
      Transaction => transactions_location
    }

    csv_info.each do |model, location|
      model.destroy_all
      CSV.foreach(location, headers: true) do |row|
        model.create!(row.to_hash)
      end
    end
  end
end
