class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = filter_results
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = filter_results(1).first
    render json: MerchantSerializer.new(merchant)
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end

  def filter_results(limit_results = nil)
    search_params.to_h.reduce([]) do |acc, (key, value)|
      acc << Merchant.where("#{key} ilike ?", "%#{value}%").limit(limit_results)
    end.flatten.uniq
  end
end
