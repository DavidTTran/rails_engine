class ApplicationController < ActionController::API
  helper_method :merchant_serializer, :item_serializer

  def merchant_serializer(object)
    MerchantSerializer.new(object)
  end

  def item_serializer(object)
    ItemSerializer.new(object)
  end
end
