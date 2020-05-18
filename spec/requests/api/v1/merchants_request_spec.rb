require 'rails_helper'

describe "Merchants API" do
  it "can return a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants["data"].count).to eq(3)
    merchants["data"].each do |merchant|
      expect(merchant).to have_key("attributes")
      expect(merchant).to have_key("type")
      expect(merchant).to have_key("id")
    end
  end

  it "can get one merchant by id" do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it "can create a new merchant" do
    merchant_params = { name: "John" }
    post "/api/v1/merchants", params: merchant_params
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can update a merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "James" }
    put "/api/v1/merchants/#{id}", params: merchant_params
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("James")
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)
    create(:item, merchant: merchant)
    create_list(:merchant, 2)

    delete "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful
    expect(Merchant.all.count).to eq(2)
  end
end
