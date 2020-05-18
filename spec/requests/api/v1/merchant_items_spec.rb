require 'rails_helper'

describe "MerchantItems API" do
  it "can return all items associated with a merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    create_list(:item, 3, merchant: merchant_1)
    create_list(:item, 5, merchant: merchant_2)

    get "/api/v1/merchants/#{merchant_1.id}/items"
    parsed_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(parsed_items["data"].count).to eq(3)
    parsed_items["data"].each do |item|
      expect(item).to have_key("id")
      expect(item).to have_value("item")
      expect(item["attributes"]).to have_key("name")
      expect(item["attributes"]).to have_key("description")
      expect(item["attributes"]).to have_key("unit_price")
    end
  end

  it "can return the merchant associated with an item" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_2)

    get "/api/v1/items/#{item_1.id}/merchant"
    parsed_merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(parsed_merchant["data"]).to have_value("merchant")
    expect(parsed_merchant["data"]).to have_value(merchant_1.id.to_s)
  end
end
