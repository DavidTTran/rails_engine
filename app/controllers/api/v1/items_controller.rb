class Api::V1::ItemsController < ApplicationController
  def index
    render json: serialize(Item.all)
  end

  def show
    render json: serialize(Item.find(params[:id]))
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    render json: serialize(item)
  end

  def update
    item = Item.update(params[:id], item_params)
    render json: serialize(item)
  end

  def destroy
    render json: serialize(Item.destroy(params[:id]))
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def serialize(object)
    ItemSerializer.new(object)
  end
end
