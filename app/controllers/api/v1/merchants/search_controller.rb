class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = []
    search_params.each do |key, value|
      merchants << Merchant.where("#{key} ilike ?", "%#{value}%")
    end
    render json: MerchantSerializer.new(merchants.flatten.uniq)
  end

  def show
  end

  private

  def search_params
    params.permit(:name, :created_at, :updated_at)
  end
end
