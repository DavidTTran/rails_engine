class Api::V1::Items::SearchController < ApplicationController
  def index
    items = FilterResults.call(Item, search_params)
    render json: ItemSerializer.new(items)
  end

  def show
    item = FilterResults.call(Item, search_params, 1).first
    render json: ItemSerializer.new(item)
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :updated_at, :created_at)
  end
end
