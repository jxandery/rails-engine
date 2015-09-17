class ChangeColumnTypesForBigDecimal < ActiveRecord::Migration
  def change
      change_column :invoice_items, :unit_price, :decimal, :precision => 8, :scale => 2
      change_column :items,         :unit_price, :decimal, :precision => 8, :scale => 2
  end
end
