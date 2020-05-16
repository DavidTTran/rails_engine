class RemoveCreditCardNumberFromTransactions < ActiveRecord::Migration[5.1]
  def change
    remove_column :transactions, :credit_card_number, :int
  end
end
