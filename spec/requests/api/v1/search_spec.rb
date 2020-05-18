require 'rails_helper'

describe "merchants search" do
  it "can find merchants with names that include the params" do
    create(:merchant, name: "Bakery")
    create(:merchant, name: "London Bakers")
    create(:merchant, name: "Lousiville")
    create(:merchant, name: "Temple")

    find_params = "?name=baker"
    get "/api/v1/merchants/find_all#{find_params}"
    expect(response).to be_successful
    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
  end
end

describe "items search" do
  before(:each) do
    @merchant_1 = create(:merchant, name: "Bakery")
    @merchant_2 = create(:merchant, name: "London Bakers")
    @item_1_params = { name: "Candy", description: "Hot and spicy", unit_price: 10.0, created_at: "2020-01-13 14:53:59 UTC" }
    @item_2_params = { name: "Can-o-Beans", description: "Comes in a jar", unit_price: 5.0 }
    @item_3_params = { name: "Jellybeans", description: "Never know what you're going to get", unit_price: 1.2, created_at: "2012-03-27 14:54:02 UTC" }
    @item_4_params = { name: "Jar of pickles", description: "jar of pickles", unit_price: 2.4 }
    @item_5_params = { name: "Car", description: "buy our car", unit_price: 5.0 }
    @merchant_1.items.create(@item_1_params)
    @merchant_1.items.create(@item_2_params)
    @merchant_1.items.create(@item_3_params)
    @merchant_2.items.create(@item_4_params)
    @merchant_2.items.create(@item_5_params)
  end

  it "can find one item with passed params name" do
    get "/api/v1/items/find?name=can"
    can_name = JSON.parse(response.body)
    expect(response).to be_successful
    expect(can_name["data"].first["attributes"]).to have_value("Hot and spicy")
    expect(can_name["data"].first["attributes"]).to have_value("Candy")
  end

  it "can find one item with passed params description" do
    get "/api/v1/items/find?description=car"
    car_description = JSON.parse(response.body)
    expect(response).to be_successful
    expect(car_description["data"].first["attributes"]).to have_value("Car")
    expect(car_description["data"].first["attributes"]).to have_value("buy our car")
  end

  it "can find one item with passed params created_at" do
    get "/api/v1/items/find?created_at=2012-03-27"
    date_created = JSON.parse(response.body)
    expect(response).to be_successful
    expect(date_created["data"].first["attributes"]).to have_value("Jellybeans")
  end

  it "can find all items with passed params names" do
    get "/api/v1/items/find_all?name=can"
    can_name = JSON.parse(response.body)
    expect(can_name["data"].count).to eq(2)
  end

  it "can find all items with passed params descriptions" do
    get "/api/v1/items/find_all?description=jar"
    jar_description = JSON.parse(response.body)
    expect(jar_description["data"].count).to eq(2)
  end

  it "can find all items with passed params prices" do
    get "/api/v1/items/find_all?unit_price=5.0"
    unit_price_5 = JSON.parse(response.body)
    expect(unit_price_5["data"].count).to eq(2)
  end

  it "can find all items with passed params name and description" do
    get "/api/v1/items/find_all?name=can&description=jar"
    can_name_jar_des = JSON.parse(response.body)
    expect(can_name_jar_des["data"].count).to eq(3)
  end
end
