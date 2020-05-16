class AddCreditCardNumberToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :credit_card_number, :bigint
  end
end
