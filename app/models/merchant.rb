class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_items_sold(merchants)
    select('merchants.*, SUM(invoice_items.quantity) AS total_sold')
    .joins(:invoices, :invoice_items, :transactions)
    .merge(Transaction.where(result: "success"))
    .group(:id)
    .order("total_sold DESC")
    .limit(merchants)
  end

  def self.revenue_total(id)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoices, :invoice_items, :transactions)
    .merge(Transaction.where(result: "success"))
    .where('merchants.id = ?', id)
    .group(:id)
  end
end
