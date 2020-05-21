class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def update
    merchant = Merchant.update(params[:id], merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  def destroy
    render json: MerchantSerializer.new(Merchant.destroy(params[:id]))
  end

  def revenue_by_date
    revenue = Merchant.revenue_by_date(params[:start], params[:end])[0]
    render json: MerchantRevenueSerializer.new(revenue)
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
