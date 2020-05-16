class CreateInvoiceItems < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_items do |t|
      t.float :unit_price
      t.string :created_at
      t.string :updated_at
    end
  end
end
