class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.string :status
      t.string :created_at
      t.string :updated_at
    end
  end
end
