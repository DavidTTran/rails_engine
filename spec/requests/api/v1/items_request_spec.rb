require 'rails_helper'

describe "Items API" do
  it "can send a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful
    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
    items["data"].each do |item|
      expect(item["attributes"]).to have_key("description")
      expect(item["attributes"]).to have_key("unit_price")
      expect(item["attributes"]).to have_key("name")
    end
  end

  it "can send 1 item by id" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}"
    item_response = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item_response.count).to eq(1)
    expect(item_response["data"]["attributes"]).to have_key("description")
    expect(item_response["data"]["attributes"]).to have_key("unit_price")
    expect(item_response["data"]["attributes"]).to have_key("name")
    expect(item_response["data"]["attributes"]).to have_value(item.name)
  end

  it "can create an item" do
    merchant = create(:merchant)
    create(:item, merchant: merchant)

    item_params = { "name" => "Test Item",
                    "description" => "Test Des",
                    "unit_price" => 2.1,
                    "merchant_id" => merchant.id }

    post "/api/v1/items", params: item_params
    expect(response).to be_successful
    item = Item.last
    expect(item.name).to eq("Test Item")
    expect(item.description).to eq("Test Des")
    expect(item.unit_price).to eq(2.1)
  end

  it "can update an item" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    previous_name = item.name
    new_item_params = { "name": "New Name",
                        "description": "New Description",
                        "unit_price": 5.0 }

    put "/api/v1/items/#{item.id}", params: new_item_params
    expect(response).to be_successful

    updated_item = Item.find(item.id)
    expect(updated_item.name).to eq("New Name")
    expect(updated_item.name).to_not eq(previous_name)
    expect(updated_item.description).to eq("New Description")
    expect(updated_item.unit_price).to eq(5.0)
  end

  it "can delete an item" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)

    expect(merchant.items.count).to eq(2)

    delete "/api/v1/items/#{item_1.id}"
    expect(response).to be_successful
    expect(merchant.items.count).to eq(1)
  end
end
