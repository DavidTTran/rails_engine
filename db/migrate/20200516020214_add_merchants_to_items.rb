class AddMerchantsToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :merchants, foreign_key: true
  end
end
