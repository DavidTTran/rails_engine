class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = FilterResults.call(Merchant, search_params)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = FilterResults.call(Merchant, search_params, 1).first
    render json: MerchantSerializer.new(merchant)
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end
end
