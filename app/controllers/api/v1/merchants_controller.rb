class Api::V1::MerchantsController < ApplicationController
  def index
    render json: serialize(Merchant.all)
  end

  def show
    render json: serialize(Merchant.find(params[:id]))
  end

  def create
    render json: serialize(Merchant.create(merchant_params))
  end

  def update
    merchant = Merchant.update(params[:id], merchant_params)
    render json: serialize(merchant)
  end

  def destroy
    delete_items
    render json: serialize(Merchant.destroy(params[:id]))
  end

  private

  def merchant_params
    params.permit(:name)
  end

  def delete_items
    Merchant.find(params[:id]).items.destroy_all
  end

  def serialize(object)
    MerchantSerializer.new(object)
  end
end
