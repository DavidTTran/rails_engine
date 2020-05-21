class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.most_items_sold(merchants)
    select('merchants.*, SUM(invoice_items.quantity) AS total_sold')
    .joins(:invoice_items, :transactions)
    .where(transactions: { result: "success" })
    .group(:id)
    .order("total_sold DESC")
    .limit(merchants)
  end

  def self.most_revenue(merchants)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items, :transactions)
    .where(transactions: { result: "success" })
    .group(:id)
    .order('revenue DESC')
    .limit(merchants)
  end

  def self.revenue_total(id)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items, :transactions)
    .where(transactions: { result: "success" })
    .where('merchants.id = ?', id)
    .group(:id)
  end

  def self.revenue_by_date(start_date, end_date)
    date_range = start_date.to_date.beginning_of_day..end_date.to_date.end_of_day
    Invoice.select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items, :transactions)
    .where(transactions: { result: "success" })
    .where(created_at: date_range)
  end
end
