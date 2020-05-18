class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant
  attributes :id, :name
  has_many :items
end
