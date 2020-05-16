class RemoveMerchantFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_reference :items, :merchants, foreign_key: true
  end
end
