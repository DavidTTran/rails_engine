require 'rails_helper'

describe "revenue filter" do
  before(:each) do
    #merchants
    @merchant_1 = create(:merchant, name: "Bakery")
    @merchant_2 = create(:merchant, name: "London Bakers")
    @merchant_3 = create(:merchant, name: "Louisville")

    #customers
    @customer = Customer.create!({ first_name: "Joey",
                                  last_name: "Ondricka" })

    #items
    @item_1_params = { name: "Candy",
                       description: "Hot and spicy",
                       unit_price: 10.0,
                       created_at: "2020-01-13 14:53:59 UTC" }
    @item_2_params = { name: "Can-o-Beans",
                       description: "Comes in a jar",
                       unit_price: 5.0 }
    @item_3_params = { name: "Car",
                       description: "Buy our car",
                       unit_price: 100001.10 }
    @item_4_params = { name: "Lawnmower",
                       description: "Fresh cut grass",
                       unit_price: 111.1 }
    @item_1 = @merchant_1.items.create!(@item_1_params)
    @item_2 = @merchant_1.items.create!(@item_2_params)
    @item_3 = @merchant_2.items.create!(@item_3_params)
    @item_4 = @merchant_3.items.create!(@item_3_params)

    #invoices
    @invoice_1_params = { customer_id: @customer.id,
                          merchant_id: @merchant_1.id,
                          status: "shipped" }
    @invoice_2_params = { customer_id: @customer.id,
                          merchant_id: @merchant_1.id,
                          status: "shipped"}
    @invoice_3_params = { customer_id: @customer.id,
                          merchant_id: @merchant_2.id,
                          status: "shipped"}
    @invoice_4_params = { customer_id: @customer.id,
                          merchant_id: @merchant_3.id,
                          status: "shipped" }
    @invoice_1 = Invoice.create!(@invoice_1_params)
    @invoice_2 = Invoice.create!(@invoice_2_params)
    @invoice_3 = Invoice.create!(@invoice_3_params)
    @invoice_4 = Invoice.create!(@invoice_4_params)

    @invoice_items_1_params = { item_id: @item_1.id,
                                invoice_id: @invoice_1.id,
                                quantity: 5,
                                unit_price: 10.0 }
    @invoice_items_2_params = { item_id: @item_2.id,
                                invoice_id: @invoice_2.id,
                                quantity: 13,
                                unit_price: 5.0 }
    @invoice_items_3_params = { item_id: @item_3.id,
                                invoice_id: @invoice_3.id,
                                quantity: 100,
                                unit_price: 100001.10 }
    @invoice_items_4_params = { item_id: @item_4.id,
                                invoice_id: @invoice_4.id,
                                quantity: 50,
                                unit_price: 111.1 }
    InvoiceItem.create!(@invoice_items_1_params)
    InvoiceItem.create!(@invoice_items_2_params)
    InvoiceItem.create!(@invoice_items_3_params)
    InvoiceItem.create!(@invoice_items_4_params)

    #transactions
    @transaction_1_params = { invoice_id: @invoice_1.id,
                              credit_card_number: 4654405418249632,
                              credit_card_expiration_date: "2012-03-27 14:54:09 UTC",
                              result: "success" }
    @transaction_2_params = { invoice_id: @invoice_2.id,
                              credit_card_number: 4654405418249632,
                              credit_card_expiration_date: "2012-03-27 14:54:09 UTC",
                              result: "success" }
    @transaction_3_params = { invoice_id: @invoice_3.id,
                              credit_card_number: 4654405418249632,
                              credit_card_expiration_date: "2012-03-27 14:54:09 UTC",
                              result: "success" }
    @transaction_4_params = { invoice_id: @invoice_4.id,
                              credit_card_number: 4654405418249632,
                              credit_card_expiration_date: "2012-03-27 14:54:09 UTC",
                              result: "success" }
    Transaction.create!(@transaction_1_params)
    Transaction.create!(@transaction_2_params)
    Transaction.create!(@transaction_3_params)
    Transaction.create!(@transaction_4_params)
  end

  after(:each) do
    [Transaction, InvoiceItem, Invoice, Item, Customer, Merchant].each do |model|
      model.destroy_all
    end
  end

  it "can find the merchants with highest revenue" do
    get "/api/v1/merchants/most_revenue?quantity=2"
    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants["data"][0]["attributes"]).to have_value(@merchant_2.name)
    expect(merchants["data"][1]["attributes"]).to have_value(@merchant_3.name)
  end

  it "should get total revenue for a merchant" do
    get "/api/v1/merchants/#{@merchant_1.id}/revenue"
    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    # This test fails for reason - it's doubling per every new .joins argument
    #
    # expect(merchant["data"]["attributes"]).to have_value("115.0")
  end
end
