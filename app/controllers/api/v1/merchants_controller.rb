class Api::V1::MerchantsController < ApplicationController
  def index
    render json: Merchant.all
  end

  def show
    render json: Merchant.find(params[:id])
  end

  def create
    render json: Merchant.create(merchant_params)
  end

  def update
    render json: Merchant.update(merchant_params)
  end

  def destroy
    delete_items
    render json: Merchant.destroy(params[:id])
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end

  def delete_items
    Merchant.find(params[:id]).items.destroy_all
  end
end
