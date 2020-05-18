class Api::V1::MerchantItemsController < ApplicationController
  def index
    items = Merchant.find(params[:merchant_id]).items
    render json: ItemSerializer.new(items).serialized_json
  end

  def merchant
    merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.new(merchant).serialized_json
  end
end
