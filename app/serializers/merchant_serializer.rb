class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  set_type :merchant
  attributes :name
  has_many :items
end
