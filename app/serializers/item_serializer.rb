class ItemSerializer < ActiveModel::Serializer
  def attributes(_)
    { "name": self.object.name,
      "description": self.object.description,
      "unit_price": self.object.unit_price }
  end
end
