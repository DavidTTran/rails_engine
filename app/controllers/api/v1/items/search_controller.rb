class Api::V1::Items::SearchController < ApplicationController
  def index
    items = filter_results
    render json: serialize(items)
  end

  def show
    item = filter_results(1).first
    render json: serialize(item)
  end

  private

  def search_params
    params.permit(:name, :description, :unit_price, :updated_at, :created_at)
  end

  def filter_results(limit_results = nil)
    search_params.to_h.reduce([]) do |acc, (key, value)|
      if key == "unit_price"
        acc << Item.where("unit_price = ?", value.to_f).limit(limit_results)
      else
        acc << Item.where("#{key} ilike ?", "%#{value}%").limit(limit_results)
      end.flatten.uniq
    end
  end

  def serialize(object)
    ItemSerializer.new(object)
  end
end
