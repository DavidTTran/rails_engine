class ItemSerializer
  include FastJsonapi::ObjectSerializer
  set_type :item
  attributes :id, :name, :description, :unit_price
  belongs_to :merchant

  attribute :merchant_id do |object|
    object.merchant_id
  end
end
