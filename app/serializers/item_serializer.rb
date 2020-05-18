class ItemSerializer
  include FastJsonapi::ObjectSerializer
  set_type :item
  attributes :name, :description, :unit_price
  belongs_to :merchant
end
