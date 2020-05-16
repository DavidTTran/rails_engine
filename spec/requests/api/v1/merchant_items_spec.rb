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
      expect(item).to have_key("type")
      expect(item).to have_value("items")
    end
  end
end
