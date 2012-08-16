class AddSupplierIdToAlerts < ActiveRecord::Migration
  def self.up
	  add_column :alerts, :supplier_id, :integer
  end

  def self.down
	  remove_column :alerts, :supplier_id
  end
end
