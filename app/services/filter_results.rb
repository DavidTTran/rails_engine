class FilterResults

  def self.call(model, search_params, limit_results = nil)
    search_params.to_h.reduce([]) do |acc, (key, value)|
      if key == "unit_price"
        acc << model.where("unit_price = ?", value.to_f).limit(limit_results)
      else
        acc << model.where("#{key} ilike ?", "%#{value}%").limit(limit_results)
      end.flatten.uniq
    end
  end
end
