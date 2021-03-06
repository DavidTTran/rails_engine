class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    merchants = Merchant.most_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.revenue_total(params[:merchant_id])
    render json: MerchantRevenueSerializer.new(merchant)
  end
end
