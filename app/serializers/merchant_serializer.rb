class MerchantSerializer < ActiveModel::Serializer
  def attributes(_)
    { "name": self.object.name }
  end
end
